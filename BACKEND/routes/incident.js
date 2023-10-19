const express = require("express");
const router = express.Router();
const verifyJWT = require("../middleware/verifyJWT");
const {
  getAllIncident,
  getSingleIncident,
  getMyIncident,
  updateIncident,
  deleteIncident,
  createIncident,
} = require("../controller/incident");

router.use(verifyJWT);
router.route("/").get(getAllIncident).post(createIncident);
router.get("report", getMyIncident);
router
  .route("/:id")
  .get(getSingleIncident)
  .patch(updateIncident)
  .delete(deleteIncident);

module.exports = router;
