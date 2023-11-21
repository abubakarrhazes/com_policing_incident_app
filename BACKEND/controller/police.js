const { CustomError } = require("../errors/customError");
const Station = require("../models/policeStation");
const asyncHandler = require("express-async-handler");

const getAllStation = asyncHandler(async (req, res) => {
    const stations = await Station.find({})
    if (stations.length <= 0) throw CustomError('No police station registered yet')
      res.json({
        status: 200,
        message: "success",
        data: stations,
      });
})

const getSingleStation = asyncHandler(async (req, res) => {
  const { id } = req.params; // Assuming the station ID is in the URL

  const station = await Station.findById(id);

  if (!station) {
    throw CustomError("Station not found", 404);
  }

  res.json({
    status: 200,
    message: "success",
    data: station,
  });
});
const createStation = asyncHandler(async (req, res) => {
    const {name} = req.body
    const station = await Station.create({ name });     
      return res.json({
        status: 200,
        message: "success",
        data: station,
      });
})
const updateStation = asyncHandler(async (req, res) => {
    const { id } = req.params; // Assuming the station ID is in the URL
    const { name } = req.body;

    const station = await Station.findById(id);

    if (!station) {
      throw CustomError("Station not found", 404);
    }

    station.name = name;
    await station.save();

})
const deleteStation = asyncHandler(async (req, res) => {
     const { id } = req.params; // Assuming the station ID is in the URL

     const station = await Station.findById(id);

     if (!station) {
       throw CustomError("Station not found", 404);
     }

     await station.remove();

     res.json({
       status: 200,
       message: "success",
       data: station,
     });
})


module.exports = {getAllStation,getSingleStation, createStation,updateStation,deleteStation}