const mongoose = require("mongoose");

const passwordResetTokenSchema = new mongoose.Schema({
  token: { type: String, required: true },
  expiration: { type: Date, required: true },
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
});

module.exports = mongoose.model("PasswordResetToken", passwordResetTokenSchema);
