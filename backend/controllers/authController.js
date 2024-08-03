const User = require('../models/user')
const jwt = require('jsonwebtoken')
const config = require('../config')
const { broadcast } = require('../utils/broadcast')
const crypto = require('crypto')
const nodemailer = require('nodemailer')

const register = async (req, res) => {
  const { username, email, password } = req.body

  try {
    const user = new User({ username, email, password })
    await user.save()
    console.log(config.JWT_SECRET)
    const token = jwt.sign({ id: user._id }, config.JWT_SECRET, {
      expiresIn: '1h',
    })

    res.status(201).json({ token })
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}

const login = async (req, res) => {
  const { email, password } = req.body

  try {
    const user = await User.findOne({ email })
    if (!user || !(await user.matchPassword(password))) {
      return res.status(400).json({ message: 'Invalid email or password' })
    }
    const username = user.username
    const token = jwt.sign({ id: user._id }, config.JWT_SECRET, {
      expiresIn: '1h',
    })

    res.json({ token, username })
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}

const forgotPassword = async (req, res) => {
  const { email } = req.body

  try {
    const user = await User.findOne({ email })
    if (!user) {
      return res.status(400).json({ message: 'User not found' })
    }

    const token = crypto.randomBytes(20).toString('hex')
    user.resetPasswordToken = token
    user.resetPasswordExpires = Date.now() + 900000
    // console.log(user)
    await user.save()

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      host: "smtp.gmail.com",
      auth: {
        user: config.EMAIL_ID,
        pass: config.EMAIL_PASSWORD,
      },
    })

    const mailOptions = {
      to: user.email,
      from: "appalchemy.devs@no-reply.com",
      subject: 'Password Reset',
      text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n
        Please click on the following link, or paste this into your browser to complete the process:\n\n
        http://localhost:5005/#/reset-password/${token}\n\n

        Link is valid for only 15 minutes. \nIf you did not request this, please ignore this email and your password will remain unchanged.\n`
    }

    transporter.sendMail(mailOptions, (err) => {
      if (err) {
        return res.status(500).json({ message: 'Error sending email' })
      }
      res.status(200).json({ message: `Reset email sent token: ${token}` })
    })
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}

const resetPassword = async (req, res) => {
  const { token, password } = req.body

  try {
    const user = await User.findOne({
      resetPasswordToken: token,
      resetPasswordExpires: { $gt: Date.now() }
    })

    if (!user) {
      return res.status(400).json({ message: 'Password reset token is invalid or has expired' })
    }

    user.password = password
    user.resetPasswordToken = undefined
    user.resetPasswordExpires = undefined
    await user.save()

    const newToken = jwt.sign({ id: user._id }, config.JWT_SECRET, {
      expiresIn: '1h',
    })

    res.status(200).json({ token: newToken })
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
}


module.exports = { register, login, forgotPassword, resetPassword }
