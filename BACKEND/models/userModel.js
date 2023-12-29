const { default: mongoose } = require("mongoose");
const bcrypt = require("bcryptjs");
const validator = require("validator");
const { CustomError } = require("../errors/customError");

const userSchema = new mongoose.Schema(
  {
    firstName: {
      type: String,
      required: [true, "Firstname is required"],
    },
    lastName: {
      type: String,
      required: [true, "Lastname is required"],
    },
    otherName: {
      type: String,
    },
    email: {
      type: String,
      required: [true, "Email is required"],
      unique: [true, "Email already in use"],
    },
    password: {
      type: String,
      required: [true, "Password is required"],
    },
    roles: {
      type: String,
      enum: ["user", "policeStation", "admin"],
      default: "user",
    },
    profilePicture: {
      type: String,
      default: "",
    },
    phoneNumber: {
      type: Number,
      required: [true, "Phone number is required"],
      unique: [true, "Phone number is already used"],
    },
    DOB: {
      type: Date,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    state: {
      type: String,
      required: true,
    },
    occupation: {
      type: String,
      required: true,
    },
    officeAddress: {
      type: String,
    },
    isActive: {
      type: Boolean,
      default: false,
    },
  },
  {
    timestamps: true,
  }
);

userSchema.pre("save", async function () {
  if (!validator.isEmail(this.email))
    throw CustomError("Not a valid email address");
  const genSalt = await bcrypt.genSalt(10);
  const hashPsw = await bcrypt.hash(this.password, genSalt);

  this.password = hashPsw;
});
const User = mongoose.model("User", userSchema);

module.exports = User;
