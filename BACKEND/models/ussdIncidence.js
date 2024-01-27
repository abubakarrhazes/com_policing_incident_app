const { default: mongoose } = require("mongoose");

const ussdIncidenceSchema = new mongoose.Schema(
  {
    phoneNumber: {
      type: Number,
      required: [true, "Phone number is required"],
    },
    sessionId: {
      type: String,
    },
    serviceCode: {
      type: String,
    },
    details: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: ["pending", "approved", "rejected"],
      default: "pending",
    },
  },
  {
    timestamps: true,
  }
);

const UssdIncidence = mongoose.model("UssdIncidence", ussdIncidenceSchema);
module.exports = UssdIncidence;
