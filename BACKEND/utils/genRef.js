const crypto = require("crypto");

const refNum = (initials) => {
  const refNum = crypto.randomBytes(3).toString("hex");
  const ref = initials + refNum;
  return ref;
};

module.exports = refNum;
