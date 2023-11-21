const express = require("express");
const router = express.Router();

const verifyJWT = require("../middleware/verifyJWT");
const { getAllStation, createStation, updateStation, deleteStation, getSingleStation } = require("../controller/police");

router.use(verifyJWT);
router.route("/").get(getAllStation).post(createStation);
// router.post("/create", createStation);


// get station account details with the station ID
// update station account details with the ID
// DELETE station account with the ID

router.route("/:id").get(getSingleStation).patch(updateStation).delete(deleteStation);

module.exports = router;
