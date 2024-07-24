const mongoose = require('mongoose');

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

module.exports = mongoose.model('Item', itemSchema);
