const express = require("express");
const router = express.Router();
const path = require("path");

const {
  login,
  logout,
  refresh,
  register,
  forgetPassword,
  resetPassword,
} = require("../controller/auth");

router.post("/login", login);
router.post("/signup", register);
router.post("/forget/password", forgetPassword);
router.post("/reset/password", resetPassword);
router.get("/forget/password", (req, res) => {
  console.log(__dirname);
  res.sendFile(path.join(__dirname, "..", "views/reset.html"));
});
router.get("/reset/password", (req, res) => {
  console.log(__dirname);
  res.sendFile(path.join(__dirname, "..", "views/password.html"));
});

// I HAVE NOT DONE THIS YET (NOT NECCESSARY)
router.post("/logout", logout);
router.get("/refresh", refresh);

module.exports = router;
