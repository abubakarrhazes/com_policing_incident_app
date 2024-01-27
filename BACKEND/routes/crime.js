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
  updateCrimeStatus,
} = require("../controller/crime");

router.use(verifyJWT);

// get all reported crimes (GET REQUEST) and report an crimes (POST REQUEST)
router.route("/").get(getAllCrime).post(createCrime);

// get my crime (that is the logged in users crimes)
router.get("/:userId/my_crimes", getMyCrime);
router
  .route("/:id")
  // get sigle crime by ID,
  .get(getSingleCrime)
  //  UPDATE crime by ID,
  .patch(updateCrime)
  //  update crime status by ID,
  .patch("/status", updateCrimeStatus)

  // Delete crime by ID
  .delete(deleteCrime);

module.exports = router;
