const express = require("express");
const router = express.Router();
const { login, logout, refresh, register } = require("../controller/auth");

router.post("/login", login);
router.post("/signup", register);

// I HAVE NOT DONE THIS YET (NOT NECCESSARY)
router.post("/logout", logout);
router.get("/refresh", refresh);

module.exports = router;
