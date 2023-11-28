const { default: mongoose } = require("mongoose");

const stationSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
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
