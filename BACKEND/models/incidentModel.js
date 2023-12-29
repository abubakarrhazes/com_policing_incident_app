const { default: mongoose } = require("mongoose");

const categoryEnum = [
  'Malware Attack',
  'Phishing',
  'Data Breach',
  'Break-ins or Burglaries',
  'Vandalism',
  'Assaults or Violent Incidents',
  'Kidnappings',
  'Vehicle Accidents',
  'Social Media Crises',
  'Fire Outbreak',
  'Exam Malpractice'
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
      enum: ["pending", "approved", "rejected"],
      default: "pending",
    },
    policeUnit: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Station",
      required: [true, "Station ID is required"],
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
    address: String,
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
