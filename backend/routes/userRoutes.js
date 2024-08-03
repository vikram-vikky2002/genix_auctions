const express = require('express')
const router = express.Router()
const { getProfile, addFavorites, getUserBids } = require('../controllers/userController')
const authMiddleware = require('../middleware/authMiddleware') // Assuming you have an authentication middleware

router.get('/profile', authMiddleware, getProfile)
router.put('/users/favorites', authMiddleware, addFavorites)
router.get('/user-bids', authMiddleware, getUserBids);
// router

module.exports = router
