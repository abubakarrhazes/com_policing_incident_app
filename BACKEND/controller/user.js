const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");
const Crime = require("../models/crimeModel");
const Incident = require("../models/incidentModel");

const getAllUsers = asyncHandler(async (req, res) => {
  const users = await User.find({}).select("-password");
  if (users?.length <= 0) throw CustomError("No user found", 200);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: users,
  });
});

const getReportByRef = asyncHandler(async (req, res) => {
  const { ref } = req.params;
  if (!ref) throw CustomError("Reference number is required");
  const { id } = req.params;

  if (!id) throw CustomError("User id is required");
  if (!mongoose.isValidObjectId(id)) throw CustomError("Not a valid user id");

  const user = await User.findById({ _id: id }).select("-password");
  if (!user) throw CustomError("No user found", 400);

  if (ref.startsWith("CR")) {
    const crime = await Crime.findOne({ ref, user: id }).exec();
    if (!crime)
      throw CustomError(
        "No reported crime with such reference number for this particular user"
      );
    return res.status(200).json({
      status: 200,
      message: "Success",
      data: crime,
    });
  } else if (ref.startsWith("IC")) {
    const incident = await Incident.findOne({ ref, user: id }).exec();
    if (!incident)
      throw CustomError(
        "No reported incident with such reference number for this particular user"
      );
    return res.status(200).json({
      status: 200,
      message: "Success",
      data: incident,
    });
  } else {
    throw CustomError("Invalid reference number");
  }
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
  getReportByRef,
  getSingleUser,
  getAccount,
  updateUser,
  deleteUser,
};
