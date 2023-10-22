const express = require("express");
const router = express.Router();
const verifyJWT = require("../middleware/verifyJWT");
const {
  getAllEmergency,
  getSingleEmergency,
  getMyEmergency,
  updateEmergency,
  deleteEmergency,
  createEmergency,
} = require("../controller/emergency");

router.use(verifyJWT);

// GET ALL EMERGENCY AND CREATE NEW EMERGENCY
router.route("/").get(getAllEmergency).post(createEmergency);

// GET USER EMERGENCIIES BY JWT
router.get("/info", getMyEmergency);

// GET USER EMERGENCIES BY EMERGENCY ID,UPDATE AND DELETE BY ID,
router
  .route("/:id")
  .get(getSingleEmergency)
  .patch(updateEmergency)
  .delete(deleteEmergency);

module.exports = router;
