const express = require("express");
const router = express.Router();
const verifyJWT = require("../middleware/verifyJWT");
const {
  getAllPost,
  createPost,
  getSinglePost,
  updatePost,
  deletePost,
} = require("../controller/post");

router.use(verifyJWT);

// GET ALL POST AND CREATE NEW POST
router.route("/").get(getAllPost).post(createPost);

// GET SINGLE POST, UPDATE AND DELETE POST WITH POST ID
router.route("/:id").get(getSinglePost).patch(updatePost).delete(deletePost);

module.exports = router;
