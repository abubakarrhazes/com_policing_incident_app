const express = require("express");
const router = express.Router();
const path = require("path");

const ussd = require("../controller/ussd");

router.post("/ussd", ussd);

module.exports = router;
