const mongoose = require('mongoose')

const bidUserSchema = new mongoose.Schema({
    price: { type: Number, required: true },
    productName: { type: String, required: true },
    time: { type: Date, required: true, default: Date.now },
})

module.exports = bidUserSchema
