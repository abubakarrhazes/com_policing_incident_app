const express = require("express");
const User = require("../models/userModel");
const router = express.Router();
const jwt = require('jsonwebtoken');
const { sendEmail, verifyEmailResponse } = require("../utils/notification");


const api_url = process.env.API_URL
// incase email was not sent to user email, call this endpoint to re send it again. user jwt token must be set after the signup
router.post('/verification', async (req, res) => {
    const accessToken = jwt.sign({userId:req.userId}, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1d' })
    
    const user = await User.findById(req.userId).exec()
    let message = verifyEmailResponse(user.firstName,accessToken)
    try {
        const mail = sendEmail(user.email, 'Email verification', message)
        res.json('Email sent')   
        
    } catch (error) {
        res.status(400).json(error.message || 'Network issues');
    }
})

// this will get called automatically when user clicks the link in the email
router.get('/verify', async (req, res) => {
    try {
        console.log('testing')
        
        const user = jwt.verify(req.query.token, process.env.ACCESS_TOKEN_SECRET);
        console.log(user,'testing')
        // Find the user by ID and set verified to true
        await User.findByIdAndUpdate(user.userId, { isActive: true });
        res.send(`Verification succesfull 😊✔,click the link to login <a href="${`http://localhost:3000/auth/login`}">click me</a>`)
        // res.redirect('http://localhost:3000/auth/login'); // Redirect to your login page
    } catch (error) {
        res.status(400).json(error.message || 'Invalid JWT');
    }
});


module.exports = router