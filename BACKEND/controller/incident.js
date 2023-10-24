const asyncHandler = require("express-async-handler");
const Incident = require("../models/incidentModel");
const { CustomError } = require("../errors/customError");
const { default: mongoose } = require("mongoose");
const {sendEmail,crimeResponse} = require("../utils/notification");

const getAllIncident = asyncHandler(async (req, res) => {
  const { status } = req.query;
  const queryObject = {};

  if (status) {
    queryObject["status"] = status;
  }
  const incident = await Incident.find(queryObject).populate('user');
  if (incident.length <= 0)
    return res.json({ message: "No incident reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: incident,
  });
});

const getMyIncident = asyncHandler(async (req, res) => {
  const {userId} = req.params;
  const incident = await Incident.find({ user: userId }).populate('user');
  if (!incident) return res.json({ message: "No incident reported yet" });
  res.json({
    status: 200,
    message: "success",
    data: incident,
  });
});
const getSingleIncident = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (mongoose.isValidObjectId(id)) throw CustomError("Not a valid ID");
  const incident = await Incident.findById(id).populate('user');
  if (!incident) {
    throw CustomError("Incident with ID not found");
  }
  res.json({
    status: 200,
    message: "success",
    data: incident,
  });
});
const createIncident = asyncHandler(async (req, res) => {
  const { category, details, location, policeUnit } = req.body;
  const { photo, video, audio, file } = req.body;
  const user = req.userId;

  const ref = refNum("IC");

  if (!category || !details) {
    throw CustomError("Category and details are required");
  }
  if (!location) {
    throw CustomError("Location is required");
  }
  if (!user) throw CustomError("You must be logged in", 401);

  const foundUser = await User.findById(user).exec()
  if(!foundUser) throw CustomError("Invalid JWT, You must be logged in", 401);
  // process photo,video,audio,file with multer
  // ******************************************

  const incident = await Incident.create({
    category,
    details,
    location,
    ref,
    policeUnit,
    user,
    photo,
    video,
    audio,
    file,
  });
 const subject = 'Incident Report!'
  const message = crimeResponse(foundUser.firstName,incident.ref)
  sendEmail(foundUser.email,subject,message)
  return res
    .status(200)
    .json({ status: 200, message: "success", data: incident });
});
const updateIncident = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { category, details, location, policeUnit } = req.body;
  const { photo, video, audio, file } = req.files;
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
    policeUnit,
    location,
    photo,
    video,
    audio,
    file,
  };
  const incident = await Incident.findByIdAndUpdate(id, queryItem);
  if (!incident) throw CustomError("Incident not found", 401);

  return res
    .status(200)
    .json({ status: 200, message: "success", data: incident });
});
const deleteIncident = asyncHandler(async (req, res) => {
  const { id } = req.params;
  if (!id) throw CustomError("Id must be given");
  const incident = await Incident.findByIdAndDelete(id);
  if (!incident) throw CustomError("Incident not found");

  return res
    .status(200)
    .json({ status: 200, message: "Incident deleted successfully" });
});

module.exports = {
  getAllIncident,
  getMyIncident,
  getSingleIncident,
  createIncident,
  updateIncident,
  deleteIncident,
};
