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
router.route("/").get(getAllPost).post(createPost);
router.route("/:id").get(getSinglePost).patch(updatePost).delete(deletePost);

module.exports = router;
