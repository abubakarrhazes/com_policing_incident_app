const express = require("express");
const router = express.Router();

// Assuming you have a database connection established and a model/schema defined

const UssdCrime = require("../models/ussdCrime");
const UssdIncidence = require("../models/ussdIncidence");

// Create an object to store session data
const sessions = {};

router.post("/", async (req, res) => {
  // Extract USSD information from the request
  let message = "";

  const { sessionId, serviceCode, phoneNumber, text } = req.body;

  // Retrieve or create a session if it doesn't exist
  if (!sessions[sessionId]) {
    sessions[sessionId] = {
      stage: "initial", // Tracks the current stage of the session
      details: "", // Stores crime or incidence details
    };
  }
  console.log(sessions);
  const currentSession = sessions[sessionId];

  if (text === "") {
    // Initial prompt
    message = "Welcome to Crime Reporting\n";
    message += "1. Report Crime\n";
    message += "2. Report Incidence";
    currentSession.stage = "initial";
  } else if (text === "1") {
    // Report Crime option
    message = " Please type the details of the crime";
    currentSession.stage = "crime";
  } else if (text === "2") {
    // Report Incidence option
    message = " Please type the details of the incidence";
    currentSession.stage = "incidence";
  } else if (currentSession.stage === "crime") {
    // Process crime details
    currentSession.details = text;
    // Save the crime details into the database using the UssdCrime model
    const newUssdCrime = await UssdCrime.create({
      details: text,
      sessionId: sessionId,
      serviceCode: serviceCode,
      phoneNumber: phoneNumber,
    });
    message = `END Thank you for reporting the crime `;
    delete sessions[sessionId]; // Clear the session data after completion
  } else if (currentSession.stage === "incidence") {
    // Process incidence details
    currentSession.details = text;
    // Save the incidence details into the database using the UssdCrime model
    const newUssdIncidence = new UssdIncidence({
      details: text,
      sessionId: sessionId,
      serviceCode: serviceCode,
      phoneNumber: phoneNumber,
      // ...other necessary fields
    });
    await newUssdIncidence.save();
    message = "END Thank you for reporting the incidence";
    delete sessions[sessionId]; // Clear the session data after completion
  } else {
    message = " Welcome to Crime Reporting\n";
    message += "1. Report Crime\n";
    message += "2. Report Incidence";
  }

  res.send(message);
});

module.exports = router;
