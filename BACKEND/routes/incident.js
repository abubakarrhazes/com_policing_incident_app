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

// get all reported INCIDENTS (GET REQUEST) and report an INCIDENTS (POST REQUEST)
router.route("/").get(getAllIncident).post(createIncident);

// get my incident (that is the logged in users incidents)
router.get("/my_incidents", getMyIncident);

router
  .route("/:id")
  // get sigle incident by ID,
  .get(getSingleIncident)
  //  UPDATE incident by ID,
  .patch(updateIncident)
  // Delete incident by ID
  .delete(deleteIncident);

module.exports = router;
