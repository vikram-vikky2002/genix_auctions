const Bid = require('../models/bid')
const bidUserSchema = require('../models/bid_user')
const Product = require('../models/product')
const User = require('../models/user')
// const { sendNotification } = require('../utils/sendNotification')

const addBid = async (req, res) => {
  const { productId, price, username } = req.body

  try {
    const product = await Product.findById(productId)

    if (!product) {
      return res.status(404).json({ message: 'Product not found' })
    }

    if (product.bids.length > 0) {
      const lastBid = product.bids[product.bids.length - 1]
      if (lastBid.username === username) {
        return res
          .status(402)
          .json({ message: 'You cannot place consecutive bids' })
      }
    }

    if (price <= product.currentBidPrice) {
      return res
        .status(400)
        .json({ message: 'Bid price must be higher than the current price' })
    }

    const newBid = {
      price,
      username,
      time: new Date(),
    }

    product.bids.push(newBid)
    product.currentBidPrice = price

    await product.save()

    // Find the user and add the bid to their bids array
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const userBid = { price: price, productName: product.title, time: new Date() };

    user.bids.push(userBid);
    await user.save();

    // Notify all connected clients about the new bid
    // newBid(newBid)

    res.status(200).json(product)
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}

const getBids = async (req, res) => {
  try {
    const item = await Bid.findById(req.params.id)
    if (item) {
      res.json(item)
    } else {
      res.status(404).json({ message: 'Item not found' })
    }
  } catch (error) {
    res.status(500).json({ message: 'Error fetching item' })
  }
}

module.exports = { addBid, getBids }
