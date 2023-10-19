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
router.route("/").get(getAllEmergency).post(createEmergency);

router.get("info", getMyEmergency);
router
  .route("/:id")
  .get(getSingleEmergency)
  .patch(updateEmergency)
  .delete(deleteEmergency);

module.exports = router;
