const jwt = require("jsonwebtoken");
const User = require("../models/userModel");

const verifyJWT = (req, res, next) => {
 if (req.url.includes('/api/v1/auth/verify') || req.url.includes('/api/v1/auth/verification')) {
    return next()
  }

  const authorization = req.headers.authorization || req.headers.Authorization;

 
  if (!authorization)
    return res.status(401).json({ message: "Not authorized" });

  const token = authorization.split(" ")[1];
  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, async (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: "Forbidden" });
    }
    const userFound = await User.findById(decoded.userId).exec()
    if (!userFound) {
        return res.status(403).json({ message: "User not registerd" });
    }
    req.userId = decoded.userId;
    next();
  });
};

module.exports = verifyJWT;
