const asyncHandler = require("express-async-handler");
const { CustomError } = require("../errors/customError");
const User = require("../models/userModel");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const {sendEmail,verifyEmailResponse,resetPasswordResponse} = require("../utils/notification");
const cloudinary = require("cloudinary").v2;

const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;
const api_url = process.env.API_URL;

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
  let profilePicture = "";

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

  if (req.file) {
    console.log("Uploading profile picture...");
    try {
      const result = await new Promise((resolve, reject) => {
        cloudinary.uploader
          .upload_stream(
            {
              folder: "policing system/images",
              resource_type: "auto",
              transformation: [{ width: 600, height: 600, crop: "fill" }],
            },
            (error, result) => {
              if (error) {
                reject(error);
              } else {
                resolve(result);
              }
            }
          )
          .end(req.file.buffer);
      });

      profilePicture = {
        public_id: result.public_id,
        format: result.format,
        url: result.url,
      };
    } catch (error) {
      console.error("Error uploading image:", error);
      return res.status(500).json({ message: "Error uploading image" });
    }
  }
  const newUser = await User.create({
    firstName,
    lastName,
    otherName,
    email,
    password,
    DOB,
    state,
    profilePicture,
    occupation,
    phoneNumber,
    address,
  });

  const accessToken = await genAccessToken(newUser.id);

  let message = verifyEmailResponse(newUser.firstName, accessToken);
  sendEmail(email, "Email verification", message);

  const user = await User.findOne({ email }).select("-password").exec();

  return res.status(200).json({
    status: 200,
    message: `New user ${newUser.firstName} created. We sent you a confirmation email`,
    data: { user: user, accessToken: accessToken },
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
  const user = await User.findOne({ email }).select("-password").exec();

  const accessToken = await genAccessToken(foundUser.id);
  return res.status(200).json({
    status: 200,
    message: "Success",
    data: { user: user, accessToken: accessToken },
  });
});

const forgetPassword = asyncHandler(async (req, res) => {
  const { email } = req.body;

  const confirmEmail = await User.findOne({ email }).exec();
  if (!confirmEmail) {
    throw CustomError("User with given email does not exist!");
  }

  const accessToken = await genAccessToken(confirmEmail.id);

  let message = resetPasswordResponse(confirmEmail.firstName, accessToken);
  try {
    await sendEmail(email, "Reset Password", message);
    // If the email is sent successfully, respond with a success message
    res.json({ message: "Email sent successfully" });
    console.log("Email sent successfully for password reset");
  } catch (error) {
    // If there's an error sending the email, respond with an error message
    res.status(500).json({ error: "Failed to send email for password reset" });
    console.error("Error sending email for password reset:", error);
  }
});

const resetPassword = asyncHandler(async (req, res) => {
  // const { token } = req.params;
  const { newPassword, token } = req.body;

  // console.log(newPassword);
  // console.log(token);
  try {
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, async (err, decoded) => {
      if (err) {
        return res.status(403).json({ message: `Forbidden,${err.message}` });
      }

      const genSalt = await bcrypt.genSalt(10);
      const hashPsw = await bcrypt.hash(newPassword, genSalt);
      const userFound = await User.findByIdAndUpdate(
        decoded.userId,
        { password: hashPsw },
        { new: true }
      ).exec();
      if (!userFound) {
        return res.status(403).json({ message: "User not registerd" });
      }
      res
        .status(200)
        .json({ message: "Password reset successful", data: userFound });
    });
  } catch (error) {
    throw CustomError(error.message || "An error occured");
  }
});



const refresh = asyncHandler(async (req, res) => {});
const logout = asyncHandler(async (req, res) => {});

module.exports = {
  register,
  login,
  refresh,
  logout,
  forgetPassword,
  resetPassword,
};
