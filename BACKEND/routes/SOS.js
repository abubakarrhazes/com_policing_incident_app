const express = require("express");
const router = express.Router();
const verifyJWT = require("../middleware/verifyJWT");
const makeEmergencyMESSAGE = require("../controller/SOS");

router.use(verifyJWT);

// get all reported INCIDENTS (GET REQUEST) and report an INCIDENTS (POST REQUEST)
router.route("/").get(makeEmergencyMESSAGE)


module.exports = router;
