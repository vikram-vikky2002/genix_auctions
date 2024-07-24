const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const User = require('../model/user');

const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key';

// Nodemailer setup
const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
    }
});

// Forgot Password Route
router.post('/forgot-password', async (req, res) => {
    try {
        const { email } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'User with this email does not exist' });
        }
        const token = jwt.sign({ userId: user._id }, JWT_SECRET, { expiresIn: '1h' });
        user.resetToken = token;
        user.resetTokenExpiration = Date.now() + 3600000; // 1 hour
        await user.save();

        const mailOptions = {
            to: user.email,
            from: process.env.EMAIL_USER,
            subject: 'Password Reset',
            html: `<p>You requested a password reset</p>
                   <p>Click this <a href="http://localhost:3000/reset/${token}">link</a> to set a new password.</p>`
        };

        await transporter.sendMail(mailOptions);
        res.json({ message: 'Password reset link sent to email' });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Reset Password Route
router.post('/reset/:token', async (req, res) => {
    try {
        const { token } = req.params;
        const { password } = req.body;
        const user = await User.findOne({
            resetToken: token,
            resetTokenExpiration: { $gt: Date.now() }
        });

        if (!user) {
            return res.status(400).json({ message: 'Invalid or expired token' });
        }

        user.password = password;
        user.resetToken = undefined;
        user.resetTokenExpiration = undefined;
        await user.save();
        res.json({ message: 'Password reset successful' });
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
