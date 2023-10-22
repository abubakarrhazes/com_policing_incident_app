const expressAsyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const { CustomError } = require("../errors/customError");

const permissions = expressAsyncHandler(async (req, res, next) => {
  const userId = req.userId;

  if (!userId) throw CustomError("Unauthorized", 401);
  const user = await User.findById(userId).exec();
  if (!user) throw CustomError("Forbidden", 403);

  const userRoles = user.roles;

  if (req.url.includes("/api/v1/blog/post")) {
    if (
      req.method === "POST" ||
      req.method === "PATCH" ||
      req.method === "DELETE"
    ) {
      if (!userRoles.includes("admin"))
        throw CustomError(
          "Forbidden! only admin has permission to perform such action"
        );
      else {
        next();
      }
    }
  }

  if (req.url.startsWith("/api/v1/police")) {
    if (
      req.method === "POST" ||
      req.method === "PATCH" ||
      req.method === "DELETE"
    ) {
      if (!userRoles.includes("admin"))
        throw CustomError(
          "Forbidden! only admin has permission to perform such action"
        );
      else {
        next();
      }
    }
  }
  next();
});

module.exports = permissions;
