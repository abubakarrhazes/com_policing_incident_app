const asyncHandler = require("express-async-handler");
const Crime = require("../models/crimeModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");
const refNum = require("../utils/genRef");
const { sendEmail, crimeResponse } = require("../utils/notification");
const User = require("../models/userModel");
const {
  videoUpload,
  audioUpload,
  photoUpload,
  fileUpload,
} = require("../utils/uploadFile");
const cloudinary = require("cloudinary").v2;

const getAllCrime = asyncHandler(async (req, res) => {
  const { status } = req.query;
  const queryObject = {};

  console.log("hey");


  const userId = req.userId;
  const foundUser = await User.findById(userId).exec();
  if (foundUser.roles !== "admin")
    throw CustomError("Only admin can access this route");

  if (status) {
    queryObject["status"] = status;
  }

  const crime = await Crime.find(queryObject).populate("user");
  if (crime.length <= 0) return res.json({ message: "No crime reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: crime,
  });
});

const getMyCrime = asyncHandler(async (req, res) => {
  const { userId } = req.params;

  const crime = await Crime.find({ user: userId }).populate("user");
  const data = crime.filter((k) => k.user._id == userId);

  if (!crime) return res.json({ message: "No crime reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: data,
  });
});
const getSingleCrime = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (mongoose.isValidObjectId(id)) throw CustomError("Not a valid ID");
  const crime = await Crime.findById(id).populate("user");
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
  const { category, details, location, policeUnit, address } = req.body;

  const ref = refNum("CR");
  const user = req.userId;

  if (!category || !details) {
    throw CustomError("Category and details are required");
  }
  if (!address) {
    throw CustomError("Address is required");
  }
  if (!location) {
    throw CustomError("Location is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);

  const foundUser = await User.findById(user).exec();
  if (!foundUser) throw CustomError("Invalid JWT, You must be logged in", 401);
  if (!policeUnit) throw CustomError("Police Unit required", 400);

  // process photo,video,audio,file with multer
  let videoUP = null;
  let audioUP = null;
  let imageUP = null;
  let fileUP = null;

  // ******************************************
  if (req.files) {
    const { image, video, audio, file } = req.files;
    console.log(req.files);
    videoUP = await videoUpload(video);
    audioUP = await audioUpload(audio);
    imageUP = await photoUpload(image);
    fileUP = await fileUpload(file);
  }

  const crime = await Crime.create({
    category,
    details,
    location,
    ref,
    user,
    photo: imageUP,
    video: videoUP,
    audio: audioUP,
    file: fileUP,
    policeUnit,
    address,
  });

  const subject = "Crime Report!";
  const message = crimeResponse(foundUser.firstName, crime.ref);

  sendEmail(foundUser.email, subject, message);

  return res.status(200).json({ status: 200, message: "success", data: crime });
});
const updateCrime = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { category, details, location, policeUnit, address } = req.body;
  // const { photo, video, audio, file } = req.file;
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
    policeUnit,
    address,
  };
  const crime = await Crime.findByIdAndUpdate(id, queryItem);
  if (!crime) throw CustomError("Crime not found", 401);

  return res.status(200).json({ status: 200, message: "success", data: crime });
});

const updateCrimeStatus = asyncHandler(async (req, res) => { 
  const { status } = req.body
const {id} = req.params
  if (!id) throw CustomError("ID must be given");
  const crime = await Crime.findByIdAndUpdate(id, {status},{new:true});
  if (!crime) throw CustomError("Crime not found", 401);

  return res.status(200).json({ status: 200, message: "success", data: crime });
})


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
  updateCrimeStatus,
  getMyCrime,
  getSingleCrime,
  createCrime,
  updateCrime,
  deleteCrime,
};
