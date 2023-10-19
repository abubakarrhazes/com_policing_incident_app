const { CustomError } = require("../errors/customError");
const Comment = require("../models/comment");
const Post = require("../models/post");

const getPostComment = asyncHandler(async (req, res) => {
  const { postId } = req.body;
  if (!postId) throw CustomError("Comment id is required");
  const comment = await Comment.find({ post: postId });
  if (!post) res.json({ message: "This post has no comment" });
});

const createComment = asyncHandler(async (req, res) => {
  const { postId, content } = req.body;
  const userId = req.userId;

  if (!postId || !content)
    throw CustomError("Post Id and content are required");
  if (!userId) throw CustomError("Login to comment");
  const findPost = await Post.findById(postId);
  if (!findPost) throw CustomError("No post found with given Id");

  const newComment = await Comment.create({
    user: userId,
    post: postId,
    content,
  });

  res.json({
    status: 200,
    message: "success",
    data: newComment,
  });
});

const deleteComment = asyncHandler(async (req, res) => {
  const { commentId } = req.body;
  if (!commentId) throw CustomError("Comment id is required");
  const comment = await Comment.findByIdAndDelete(commentId);
  if (!comment) res.json({ message: "This comment has no comment" });
  res.json({
    status: 200,
    message: "success",
    data: "",
  });
});

module.exports = {
  getPostComment,
  createComment,
  deleteComment,
};
