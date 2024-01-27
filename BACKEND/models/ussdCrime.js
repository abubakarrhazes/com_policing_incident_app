const { default: mongoose } = require("mongoose");

const categoryEnum = [
  "Homocide",
  "Robbery",
  "Sexual assault and rape",
  "Domestic violence",
  "Kidnapping",
  "Reckless Driving",
  "Online fraud",
  "Motor Vehicle Theft",
  "Arson",
  "Ritual Killings",
  "Drug trafficking/ Possession",
  "Cultism",
];
const ussdCrimeSchema = new mongoose.Schema(
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

const UssdCrime = mongoose.model("UssdCrime", ussdCrimeSchema);
module.exports = UssdCrime;
