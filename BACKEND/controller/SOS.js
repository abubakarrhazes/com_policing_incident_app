const Emergency = require("../models/emergencyModel");
const asyncHandler = require("express-async-handler");

const makeEmergencyMESSAGE = asyncHandler(async (req, res) => {
    const user = req.userId

    const emergency = await Emergency.find({ user: user }).exec()
    const info = emergency.map(i => (i.mobileNumber,i.email))
    
    res.json({data : info})
})


module.exports = makeEmergencyMESSAGE