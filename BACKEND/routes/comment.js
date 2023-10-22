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

// GET ALL COMMENTS AND CREATE A NEW COMMENT
router.route("/").get(getPostComment).post(createComment);

// delete comment by ID
router.route("/:id").delete(deleteComment);

module.exports = router;
