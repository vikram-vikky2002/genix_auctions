const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
// const authRoutes = require('./routes/auth');
// const resetRoutes = require('./routes/reset');
// const itemRoutes = require('./routes/items');

dotenv.config();

// APP config
const app = express();
const port = process.env.PORT || 3000;

// MIDDLEWARE config
app.use(express.json());
app.use(cors());

// DATABASE setup
mongoose.connect(process.env.MONGODB_URI);

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
    console.log('Connected to the database');
});


const bidHistorySchema = new mongoose.Schema({
    name: { type: String, required: true },
    bidValue: { type: Number, required: true },
    date: { type: Date },
});

const itemSchema = new mongoose.Schema({
    name: { type: String, required: true },
    minimumBid: { type: Number, required: true },
    currentBid: { type: Number, required: true },
    description: { type: String, required: true },
    image: { type: String, required: true },
    category: { type: String, required: true },
    seller: { type: String, required: true },
    endDate: { type: Date, required: true },
    status: { type: String, required: true },
    history: { type: [bidHistorySchema], default: [] }
});


const Item = mongoose.model('Item', itemSchema);

const transactionSchema = new mongoose.Schema({
    title: { type: String, required: true },
    bidValue: { type: Number, required: true },
    date: { type: Date },
});

const userSchema = new mongoose.Schema({
    _id: { type: String, required: true }, // Use email as the ID
    name: { type: String, required: true },
    password: { type: String, required: true },
    contact: { type: String, default: '' },
    age: { type: Number, default: 0 },
    gender: { type: String, default: '' },
    transactions: { type: [transactionSchema], default: [] }
});

const User = mongoose.model('User', userSchema);

function auth(req, res, next) {
    const token = req.header('Authorization');
    if (!token) return res.status(401).json({ message: 'Access denied. No token provided.' });
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        req.user = decoded;
        next();
    } catch (ex) {
        res.status(400).json({ message: 'Invalid token.' });
    }
}

app.get('/api/v1/items', async (req, res) => {
    try {
        const items = await Item.find({});
        res.json(items);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching items' });
    }
});

app.post('/api/v1/items', async (req, res) => {
    try {
        const newItem = new Item(req.body);
        await newItem.save();
        res.status(201).json(newItem);
    } catch (error) {
        res.status(400).json({ message: 'Error creating item', error });
    }
});

app.get('/api/v1/items/:id', async (req, res) => {
    try {
        const item = await Item.findById(req.params.id);
        if (item) {
        res.json(item);
        } else {
            res.status(404).json({ message: 'Item not found' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Error fetching item' });
    }
});

// POST route for bidding
app.post('/api/v1/items/:id/bid', async (req, res) => {
    const { id } = req.params;
    const { name, bidValue, date, userEmail } = req.body; // Assume userEmail is included in the request body

    try {
        console.log('Received date:', date);
        // Parse the date string to a JavaScript Date object
        const parsedDate = new Date(date);
        console.log('Parsed date:', parsedDate);
        if (isNaN(parsedDate.getTime())) {
            return res.status(400).json({ message: 'Invalid date format' });
        }

        // Find the item by ID
        const item = await Item.findById(id);
        if (!item) {
            return res.status(404).json({ message: 'Item not found' });
        }

        // Validate the bid value
        if (bidValue <= item.currentBid) {
            return res.status(400).json({ message: 'Bid value must be higher than the current bid' });
        }

        // Update the item's bid history and current bid
        item.history.push({ name, bidValue, date: parsedDate });
        item.currentBid = bidValue;
        await item.save();

        // Find the user by email
        const user = await User.findById(userEmail);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Update the user's transactions
        user.transactions.push({ title: item.name, bidValue, date: parsedDate });
        await user.save();

        res.status(200).json(item);
    } catch (error) {
        console.error('Error processing bid:', error);
        res.status(500).json({ message: 'Error processing bid', error: error.message });
    }
});

// User signup
app.post('/api/v1/auth/signup', async (req, res) => {
    const { name, email, password } = req.body;
    const user = await User.findById(email);
    if (user) return res.status(400).json({ message: 'User already exists' });
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({_id: email, name, email, password: hashedPassword });

    try {
        await newUser.save();
        res.status(201).json({ message: 'User created successfully' });
    } catch (error) {
        res.status(400).json({ message: 'Error creating user' });
    }
});

// User login
app.post('/api/v1/auth/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findById(email);
    if (!user) return res.status(400).json({ message: 'Invalid email or password' });

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) return res.status(400).json({ message: 'Invalid email or password' });

    const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
    const userName = user.name
    res.json({ token, userName });
});

// Get user profile
app.get('/api/v1/profile', auth, async (req, res) => {
    try {
        const user = await User.findById(req.user._id);
        if (!user) return res.status(404).json({ message: 'User not found' });

        res.json(user);
        } catch (error) {
        res.status(500).json({ message: 'Error fetching user profile' });
        }
    });

    // Update user profile
    app.put('/api/v1/profile', auth, async (req, res) => {
        const { name, contact, age, gender } = req.body;

        try {
        const updatedUser = await User.findByIdAndUpdate(
            req.user._id,
            { name, contact, age, gender },
            { new: true }
        );

        if (!updatedUser) return res.status(404).json({ message: 'User not found' });

        res.json(updatedUser);
        } catch (error) {
        res.status(500).json({ message: 'Error updating user profile' });
        }
    });

// Listeners
app.listen(port, () => {
    console.log(`Server is running on port: ${port}`);
});
