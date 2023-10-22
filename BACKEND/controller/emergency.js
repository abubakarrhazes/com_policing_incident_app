const asyncHandler = require("express-async-handler");
const Emergency = require("../models/emergencyModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");

const getAllEmergency = asyncHandler(async (req, res) => {
  const emergency = await Emergency.find({});
  if (emergency.length <= 0)
    return res.json({ message: "No emergency reported yet" }).populate('user');
  res.json({
    status: 200,
    message: "success",
    data: emergency,
  });
});

const getMyEmergency = asyncHandler(async (req, res) => {
  const userId = req.userId;
  const emergency = await Emergency.find({ user: userId }).populate('user');
  if (!emergency) return res.json({ message: "No emergency reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: emergency,
  });
});
const getSingleEmergency = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (mongoose.isValidObjectId(id)) throw CustomError("Not a valid ID");
  const emergency = await Emergency.findById(id).populate('user');
  if (!emergency) {
    throw CustomError("Emergency with ID not found");
  }
  res.json({
    status: 200,
    message: "success",
    data: emergency,
  });
});
const createEmergency = asyncHandler(async (req, res) => {
  const { name, email, mobileNumber, relation, address } = req.body;
  const user = req.userId;

  if (!name || !email) {
    throw CustomError("Name and email are required");
  }
  if (!mobileNumber) {
    throw CustomError("Mobile number is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);

  const emergency = await Emergency.create({
    user,
    name,
    email,
    mobileNumber,
    relation,
    address,
  });

  return res
    .status(200)
    .json({ status: 200, message: "success", data: emergency });
});
const updateEmergency = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { name, email, mobileNumber, relation, address } = req.body;
  const user = req.userId;
  const queryItem = {};

  if (!id) throw CustomError("ID must be given");
  if (!name || !email) {
    throw CustomError("Name and email are required");
  }
  if (!mobileNumber) {
    throw CustomError("Mobile number is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);
  queryItem = {
    name,
    email,
    mobileNumber,
    relation,
    address,
  };
  const emergency = await Emergency.findByIdAndUpdate(id, queryItem);
  if (!emergency) throw CustomError("Emergency not found", 401);

  return res
    .status(200)
    .json({ status: 200, message: "success", data: emergency });
});
const deleteEmergency = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) throw CustomError("Id must be given");
  const emergency = await Emergency.findByIdAndDelete(id);
  if (!emergency) throw CustomError("Emergency not found");

  return res
    .status(200)
    .json({ status: 200, message: "Emergency deleted successfully" });
});

module.exports = {
  getAllEmergency,
  getMyEmergency,
  getSingleEmergency,
  createEmergency,
  updateEmergency,
  deleteEmergency,
};
