const mongoose = require('mongoose')
const bcrypt = require('bcryptjs')
const bidUserSchema = require('./bid_user')

const userSchema = new mongoose.Schema({
  username: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  favorites: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Product' }],
  products: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Product' }],
  bids: [{ type: [bidUserSchema], default: [] }],
  resetPasswordToken: { type: String },
  resetPasswordExpires: { type: Date },
})

userSchema.pre('save', async function (next) {
  if (!this.isModified('password')) return next()
  const salt = await bcrypt.genSalt(10)
  this.password = await bcrypt.hash(this.password, salt)
  next()
})

userSchema.methods.matchPassword = async function (password) {
  return await bcrypt.compare(password, this.password)
}

module.exports = mongoose.model('User', userSchema)
