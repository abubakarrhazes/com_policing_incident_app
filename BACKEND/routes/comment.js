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
const {
  getPostComment,
  createComment,
  deleteComment,
} = require("../controller/comment");

router.use(verifyJWT);
router.route("/").get(getPostComment).post(createComment);
router.route("/:id").delete(deleteComment);

module.exports = router;
