const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");

const getAllUsers = asyncHandler(async (req, res) => {
  const users = await User.find({}).select("-password");
  if (users?.length <= 0) throw CustomError("No user found", 200);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: users,
  });
});

const getSingleUser = asyncHandler(async (req, res) => {
  const { id } = req.params;

  if (!id) throw CustomError("User id is required");
  if (!mongoose.isValidObjectId(id)) throw CustomError("Not a valid user id");

  const user = await User.findById({ _id: id }).select("-password");
  if (!user) throw CustomError("No user found", 400);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: user,
  });
});
const getAccount = asyncHandler(async (req, res) => {
  const userId = req.userId;

  if (!userId) throw CustomError("unauthorizeed", 401);
  if (!mongoose.isValidObjectId(userId))
    throw CustomError("Not a valid user id");

  const user = await User.findById({ _id: userId }).select("-password");

  if (!user) throw CustomError("No user found", 400);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: user,
  });
});
const updateUser = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const data = req.body;
  
  if (!id) throw CustomError("User id is required");
  if (!mongoose.isValidObjectId(id)) throw CustomError("Not a valid user id");

  const user = await User.findByIdAndUpdate(id, { ...data }).exec();
  if (!user) throw CustomError("No user found", 400);

  return res.status(200).json({
    status: 200,
    message: "Success",
    data: user,
  });
});
const deleteUser = asyncHandler(async (req, res) => {
  const { id } = req.params;

  if (!id) throw CustomError("User id is required");
  if (!mongoose.isValidObjectId(id)) throw CustomError("Not a valid user id");

  const user = await User.findByIdAndDelete(id).exec();
  if (!user) throw CustomError("No user found", 400);

  return res.status(200).json({
    status: 200,
    message: "User deleted succesfully",
    data: "",
  });
});

module.exports = {
  getAllUsers,
  getSingleUser,
  getAccount,
  updateUser,
  deleteUser,
};
