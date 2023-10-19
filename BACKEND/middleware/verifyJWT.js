const jwt = require("jsonwebtoken");
const User = require("../models/userModel");

const verifyJWT = (req, res, next) => {
  const authorization = req.headers.authorization || req.headers.Authorization;

  if (!authorization)
    return res.status(401).json({ message: "Not authorized" });

  const token = authorization.split(" ")[1];
  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: "Forbidden" });
    }
    req.userId = decoded.userId;
    next();
  });
};

module.exports = verifyJWT;
