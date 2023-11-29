const { CustomError } = require("../errors/customError");

const cloudinary = require("cloudinary").v2;

const upload = async (file, type) => {
  try {
    const result = await new Promise((resolve, reject) => {
      cloudinary.uploader
        .upload_stream(
          {
            folder: `policing system/${type}`,
            resource_type: "auto",
            // transformation: [{ width: 640, height: 400, crop: "fill" }],
          },
          (error, result) => {
            if (error) {
              console.log(error, "error");
              reject(error);
            } else {
              resolve(result);
            }
          }
        )
        .end(file[0].buffer);
    });

    const data = {
      public_id: result.public_id,
      format: result.format,
      url: result.url,
    };
    return data;
  } catch (error) {
    console.error("Error uploading:", error);
    throw CustomError("Error while uploading" ,error);
  }
};
const videoUpload = async (file) => {
  if (!file) return {};
  const video = await upload(file, "videos");
  return video;
};
const photoUpload = async (file) => {
  if (!file) return {};
  const photo = await upload(file, "images");
  return photo;
};
const audioUpload = async (file) => {
  if (!file) return {};
  const audio = await upload(file, "audio");
  return audio;
};
const fileUpload = async (file) => {
  if (!file) return {};
  const data = await upload(file, "files");
  return data;
};

module.exports = { videoUpload, photoUpload, audioUpload, fileUpload };
