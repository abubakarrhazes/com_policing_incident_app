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
const incidentSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User is required"],
    },
    ref: {
      type: String,
      required: true,
      unique: true,
    },
    category: {
      type: String,
      enum: categoryEnum,
    },
    details: {
      type: String,
      required: true,
    },
    status: {
      type: String,
      enum: ["Pending", "Approved", "Rejected"],
      default: "pending",
    },
    policeUnit: {
      type: String,
      enum: ["zaria police station", "kastina police station"],
      required: true,
    },
    location: {
      latitude: {
        type: String,
        required: true,
      },
      logitude: {
        type: String,
        required: true,
      },
    },
    photo: String,
    video: String,
    audio: String,
    file: String,
  },
  {
    timestamps: true,
  }
);

const Incident = mongoose.model("Incident", incidentSchema);
module.exports = Incident;
