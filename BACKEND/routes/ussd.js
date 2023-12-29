const express = require("express");
const router = express.Router();
const path = require("path");

// Assuming you have a database connection established and a model/schema defined
const Crime = require("../models/crimeModel");
const User = require("../models/userModel");

router.post("/", async (req, res) => {
  // Extract USSD information from the request
  const { sessionId, serviceCode, phoneNumber, text } = req.body;
  let response = "";

  console.log(req.body, "african talking");

  try {
    let user = await User.findOne({ phoneNumber });

    if (!user) {
      // If user doesn't exist, create a new user
      const userData = { phoneNumber };
      user = await User.create(userData);
    }

    // Process USSD input and create a response based on user input
    if (!user.firstName) {
      if (text === "1") {
        response = "Enter Firstname:";
        // Update user's first name once provided
        // For example, if you have a field 'firstName' in your User schema
        // Replace 'firstName' with your actual field name
        user.firstName = text; // Assuming 'text' contains the entered first name
        await user.save();
      } else {
        response = 'Welcome to Your USSD App\n1. Create an account \n2. Cancel';
      }
    } else {
      // Handle other USSD options once the user's first name is set
      if (text === "1") {
        // Perform actions related to Option One in the database
        response = "CON Option One selected. Database updated!";
        // Update the database or perform actions as required
      } else if (text === "2") {
        // Perform actions related to Option Two in the database
        response = "CON Option Two selected. Database updated!";
        // Update the database or perform actions as required
      } else {
        response = `Welcome to Your USSD App\n1. Report crime\n2. Report Incidence`;
      }
    }

    // Send the USSD response
    res.send(response);
  } catch (error) {
    console.error("Error:", error);
    response = "CON Error processing your request. Please try again.";
    res.send(response);
  }
});

module.exports = router;
