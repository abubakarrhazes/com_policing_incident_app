const express = require("express");
const router = express.Router();
const verifyJWT = require("../middleware/verifyJWT");
const {
  getAllCrime,
  getSingleCrime,
  getMyCrime,
  updateCrime,
  deleteCrime,
  createCrime,
} = require("../controller/crime");

router.use(verifyJWT);
router.route("/").get(getAllCrime).post(createCrime);
router.get("report", getMyCrime);
router.route("/:id").get(getSingleCrime).patch(updateCrime).delete(deleteCrime);

module.exports = router;
