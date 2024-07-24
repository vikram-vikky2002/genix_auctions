const mongoose = require('mongoose')

const connection = mongoose.createConnection('mongodb://0.0.0.0:27017/genix').on('open',() => {
    console.log('connected to MongoDB');
}).on('error', () => {
    console.log('error connecting to MongoDB');
});

module.exports = connection;