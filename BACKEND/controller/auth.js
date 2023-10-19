const asyncHandler = require("express-async-handler");
const { CustomError } = require("../errors/customError");
const User = require("../models/userModel");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;

const genAccessToken = async (user_id) => {
  const accessToken = jwt.sign({ userId: user_id }, ACCESS_TOKEN_SECRET, {
    expiresIn: "1d",
  });
  return accessToken;
};

const register = asyncHandler(async (req, res) => {
  const {
    firstName,
    lastName,
    otherName,
    email,
    password,
    DOB,
    state,
    occupation,
    phoneNumber,
    address,
  } = req.body;
  const profilePicture = req.file;

  // ///////////////// profile picture setting

  if (!firstName || !lastName) {
    throw CustomError("Firstname and Lastname are required", 400);
  }
  if (!email || !password) {
    throw CustomError("Email and password are required", 400);
  }
  if (!validator.isEmail(email)) throw CustomError("Not a valid email");
  const confirmEmail = await User.findOne({ email }).exec();
  if (confirmEmail) throw CustomError("Email already in use", 400);

  if (password.length < 5) {
    throw CustomError("Password can't be less than five characters", 400);
  }

  // const genSalt = bcrypt.genSalt(10);
  // const hashPsw = bcrypt.hash(password, genSalt);

  const newUser = await User.create({
    firstName,
    lastName,
    otherName,
    email,
    password,
    DOB,
    state,
    occupation,
    phoneNumber,
    address,
  });

  const accessToken = await genAccessToken(newUser.id);
  return res.status(200).json({
    status: 200,
    message: `New user ${newUser.firstName} created`,
    data: { accessToken: accessToken },
  });
});

const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  console.log(req.file);
  // validate data
  if (!email || !password) {
    throw CustomError("All fields are required", 400);
  }

  const foundUser = await User.findOne({ email }).exec();

  if (!foundUser) {
    // status 401 stands for unauthorized
    throw CustomError("No user found with this email", 401);
  }
  // if (!foundUser.isActive) {
  //   throw CustomError("Verify your account", 200);
  // }

  const match = await bcrypt.compare(password.toString(), foundUser.password);
  if (!match) {
    throw CustomError("Wrong password", 401);
  }

  const accessToken = await genAccessToken(foundUser.id);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: { accessToken: accessToken },
  });
});

const verifyAccount = asyncHandler(async (req, res) => {});
const refresh = asyncHandler(async (req, res) => {});
const logout = asyncHandler(async (req, res) => {});

module.exports = { register, login, refresh, logout };
