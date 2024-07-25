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
});

const Item = mongoose.model('Item', itemSchema);

const userSchema = new mongoose.Schema({
    _id: { type: String, required: true },
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});

const User = mongoose.model('User', userSchema);

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
    res.json({ token });
});


// Routes
// app.use('/api/v1/auth', authRoutes);
// app.use('/api/v1/reset', resetRoutes);
// app.use('/api/v1/items', itemRoutes);

// Listeners
app.listen(port, () => {
    console.log(`Server is running on port: ${port}`);
});
