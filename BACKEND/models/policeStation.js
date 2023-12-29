const { default: mongoose } = require("mongoose");

const stationSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    address: {
      type: String,
    },
    telephone: String,
    // DPO: {
    //   type: String,
    //   required: true,
    // },
  },
  {
    timestamps: true,
  }
);

const Station = mongoose.model("Station", stationSchema);
module.exports = Station;
