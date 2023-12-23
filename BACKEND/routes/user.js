const express = require("express");
const router = express.Router();
const {
  getAllUsers,
  getSingleUser,
  updateUser,
  deleteUser,
  getAccount,
  getReportByRef,
} = require("../controller/user");
const verifyJWT = require("../middleware/verifyJWT");

router.use(verifyJWT);
router.route("/").get(getAllUsers);

// get logged in user account details (uses the user ID from the jwt to figure out the logged in user)
router.get("/account", getAccount);
router.get("/:id/reports", getReportByRef);

// get user account details with the user ID
// update user account details with the ID
// DELETE user account with the ID

router.route("/:id").get(getSingleUser).patch(updateUser).delete(deleteUser);

module.exports = router;
