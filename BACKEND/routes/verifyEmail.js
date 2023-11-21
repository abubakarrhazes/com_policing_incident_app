const express = require("express");
const User = require("../models/userModel");
const router = express.Router();
const jwt = require('jsonwebtoken');
const { sendEmail, verifyEmailResponse } = require("../utils/notification");
const verifyJWT = require("../middleware/verifyJWT");
const { CustomError } = require("../errors/customError");

const api_url = process.env.API_URL;
// incase email was not sent to user email, call this endpoint to re send it again. user jwt token must be set after the signup
router.post("/verification", verifyJWT, async (req, res) => {
  const accessToken = jwt.sign(
    { userId: req.userId },
    process.env.ACCESS_TOKEN_SECRET,
    { expiresIn: "1d" }
  );

  const user = await User.findById(req.userId).exec();
  let message = verifyEmailResponse(user.firstName, accessToken);
  try {
    const mail = sendEmail(user.email, "Email verification", message);
    res.json("Email sent");
  } catch (error) {
    res.status(400).json(error.message || "Network issues");
  }
});

// this will get called automatically when user clicks the link in the email
router.get("/verify", async (req, res) => {
  try {
    console.log("testing");

    const user = jwt.verify(
      req.query.token,
      process.env.ACCESS_TOKEN_SECRET,
      async (err, decoded) => {
        if (err) throw CustomError("invalid token");
        // Find the user by ID and set verified to true
        await User.findByIdAndUpdate(decoded.userId, { isActive: true });
        res.send(`Verification succesfull 😊✔`);
      }
    );
  } catch (error) {
    res.status(400).json(error.message || "Invalid JWT");
  }
});


module.exports = router