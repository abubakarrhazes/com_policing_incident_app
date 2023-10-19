class CustomErrorApi extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
  }
}

class BadRequest extends CustomErrorApi {
  constructor(message) {
    super(message);
    this.statusCode = 400;
  }
}

const CustomError = (msg, status) => {
  const statusCode = status || 400;
  return new CustomErrorApi(msg, statusCode);
};

module.exports = {
  CustomErrorApi,
  BadRequest,
  CustomError,
};
