const express = require("express");
const router = express.Router();
const path = require("path");

const ussd = require("../controller/ussd");

// router.post("/ussd", ussd);

router.post("/", async (req, res) => {
  // Extract USSD information from the request
  const { sessionId, serviceCode, phoneNumber, text } = req.body;
  console.log(req.body, "african talking");
  // Process USSD input and create a response
  const response = `CON Welcome to Your USSD App\n1. Option One\n2. Option Two`;

  // Send the USSD response
  res.send(response);
});

module.exports = router;
