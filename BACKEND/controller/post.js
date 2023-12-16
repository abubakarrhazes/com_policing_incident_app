const asyncHandler = require("express-async-handler");
const Post = require("../models/post");
const { CustomError } = require("../errors/customError");

const getAllPost = asyncHandler(async (req, res) => {
  const { title, description } = req.query;
  const post = await Post.find({});
  if (post.length <= 0) {
    return res.json({ message: "No post found yet" });
  }
  res.json({
    status: 200,
    message: "success",
    data: post,
  });
});
const getSinglePost = asyncHandler(async (req, res) => {
  const { postId } = req.params;
  if (!postId) throw CustomError("Post id is required");
  const post = await Post.findById(postId).exec();
  if (!post) throw CustomError("No post with such id");
  res.json({
    status: 200,
    message: "success",
    data: post,
  });
});

const createPost = asyncHandler(async (req, res) => {
  const { title, description } = req.body;
  const userId = req.userId;

  let imageUP = null;
  // process image
  if (!title || !description)
    throw CustomError("Title and description are required");
  if (!userId) throw CustomError("Login to to create post");

  if (req.files) {
    const { image } = req.file;
    imageUP = await photoUpload(image);
  }
  const newPost = await Post.create({
    title,
    description,
    image: imageUP,
    user: userId,
  });
  res.json({
    status: 200,
    message: "success",
    data: newPost,
  });
});
const updatePost = asyncHandler(async (req, res) => {
  const { postId } = req.params;
  const { title, description } = req.body;
  const { postImage } = req.file;
  const userId = req.userId;
  const imageLink = "";
  // process image
  if (!userId) throw CustomError("Login to update post");

  if (!title || !description)
    throw CustomError("Title and description are required");
  const updatedPost = await Post.findByIdAndUpdate(postId, {
    title,
    description,
    imageLink,
    user: userId,
  }).exec();
  res.json({
    status: 200,
    message: "success",
    data: updatedPost,
  });
});
const deletePost = asyncHandler(async (req, res) => {
  const { postId } = req.params;
  if (!postId) throw CustomError("Post id is required");
  const post = await Post.findByIdAndDelete(postId).exec();
  if (!post) throw CustomError("No post with such id");
  res.json({
    status: 200,
    message: "success",
    data: "",
  });
});

module.exports = {
  getAllPost,
  getSinglePost,
  createPost,
  updatePost,
  deletePost,
};
