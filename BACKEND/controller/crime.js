const asyncHandler = require("express-async-handler");
const Crime = require("../models/crimeModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");
const refNum = require("../utils/genRef");

const getAllCrime = asyncHandler(async (req, res) => {
  const { status } = req.query;
  const queryObject = {};

  if (status) {
    queryObject["status"] = status;
  }
  const crime = await Crime.find(queryObject).populate('user');
  if (crime.length <= 0) return res.json({ message: "No crime reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: crime,
  });
});

const getMyCrime = asyncHandler(async (req, res) => {
  const userId = req.userId;
  const crime = await Crime.find({ user: userId }).populate('user');
  if (!crime) return res.json({ message: "No crime reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: crime,
  });
});
const getSingleCrime = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (mongoose.isValidObjectId(id)) throw CustomError("Not a valid ID");
  const crime = await Crime.findById(id).populate('user');
  if (!crime) {
    throw CustomError("Crime with ID not found");
  }
  res.json({
    status: 200,
    message: "success",
    data: crime,
  });
});
const createCrime = asyncHandler(async (req, res) => {
  const { category, details, location, policeUnit } = req.body;
  const { photo, video, audio, file } = req.body;

  const ref = refNum("CR");
  console.log(req);
  const user = req.userId;

  if (!category || !details) {
    throw CustomError("Category and details are required");
  }
  if (!location) {
    throw CustomError("Location is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);

  // process photo,video,audio,file with multer
  // ******************************************

  const crime = await Crime.create({
    category,
    details,
    location,
    ref,
    user,
    photo,
    video,
    audio,
    file,
    policeUnit,
  });

  return res.status(200).json({ status: 200, message: "success", data: crime });
});
const updateCrime = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { category, details, location, policeUnit } = req.body;
  const { photo, video, audio, file } = req.file;
  const user = req.userId;
  const queryItem = {};

  if (!id) throw CustomError("ID must be given");
  if (!category || !details) {
    throw CustomError("Category and details are required");
  }
  if (!location) {
    throw CustomError("Location is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);
  queryItem = {
    category,
    details,
    location,
    photo,
    video,
    audio,
    file,
    policeUnit,
  };
  const crime = await Crime.findByIdAndUpdate(id, queryItem);
  if (!crime) throw CustomError("Crime not found", 401);

  return res.status(200).json({ status: 200, message: "success", data: crime });
});
const deleteCrime = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) throw CustomError("Id must be given");
  const crime = await Crime.findByIdAndDelete(id);
  if (!crime) throw CustomError("Crime not found");

  return res
    .status(200)
    .json({ status: 200, message: "Crime deleted successfully" });
});

module.exports = {
  getAllCrime,
  getMyCrime,
  getSingleCrime,
  createCrime,
  updateCrime,
  deleteCrime,
};
