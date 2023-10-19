const { default: mongoose } = require("mongoose");
const validator = require("validator");
const { CustomError } = require("../errors/customError");
const emergencySchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: [true, "User is required"],
    },
    name: {
      type: String,
      required: true,
    },
    mobileNumber: {
      type: Number,
      required: true,
    },
    email: {
      type: String,
    },
    relation: {
      type: String,
    },
    address: String,
  },
  {
    timestamps: true,
  }
);

emergencySchema.pre("save", async function () {
  if (!validator.isEmail(this.email))
    throw CustomError("Not a valid email address");
});
const Emergency = mongoose.model("Emergency", emergencySchema);
module.exports = Emergency;
