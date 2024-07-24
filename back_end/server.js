const express = require('express')
const db = require('./database')

// APP config
const app = express()
const port = 3000;


// MIDDLEWARE config
app.use(express.json());

// DATABASE setup
let itemsList = [
    {id: 1, name: "Vikram"}
];


// CRUD API operations
app.get('/api/v1/items', (req, res) => {
    return res.json(itemsList);
});

app.post('/api/v1/items', (req, res) => {
    let newItem = {
        id: itemsList.length + 1,
        name: req.body.name
    }
    itemsList.push(newItem);
    res.status(201).json(newItem);
});

app.put('/api/v1/items', (req, res) => {
    let itemId = req.params.id;
    let updatedItem = req.body;
    let index = itemsList.findIndex(item => item.id === itemId);

    if(index !== -1) {
        itemsList[index] = updatedItem;
        res.json(updatedItem);
    } else {
        res.status(404).json({message: "Item not found!"});
    }
});

app.delete('/api/v1/items', (req, res) => {
    let itemId = req.params.id;
    let index = itemsList.findIndex(item => item.id === itemId);

    if(index !== -1) {
        let deleteItem = itemsList.splice(index, 1);
        res.json(deleteItem[0]);
    } else {
        res.status(404).json({message: "Item not found!"});
    }
});

// listners
app.listen(port, () => {
    console.log(`Server is running on port : ${port}`);
});