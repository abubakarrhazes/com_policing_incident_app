require("dotenv").config();
const express = require("express");
const app = express();
const multer = require("multer");
const connectDB = require("./config/dbConn"); // Import the database connection file
const mongoose = require("mongoose");
const errorHandler = require("./middleware/errorHandler");
const permissions = require("./middleware/permissions");
const verifyJWT = require("./middleware/verifyJWT");
const cors = require("cors");
const createMessage = require("./utils/sendMessage");
const sendEmail = require("./utils/notification");
const PORT = process.env.PORT || 3500;



const cloudinary = require('cloudinary').v2;
          
cloudinary.config({ 
  cloud_name: 'dhiengvju', 
  api_key: process.env.CLOUDINARY_KEY, 
  api_secret:  process.env.CLOUDINARY_SECRET
});
// Connect to MongoDB
connectDB();


const AfricasTalking = require("africastalking");

// Initialize Africa's Talking
const username = process.env.AFRICAN_TALKING_USERNAME;
const apiKey = process.env.AFRICAN_TALKING;

const africasTalking = AfricasTalking({
  apiKey: apiKey,
  username: "sandbox",
});

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// middleware
app.use(express.json());
app.use(cors());

// routes
app.get("/", (req, res) => {
  res.send("index route");
});

// const sms = africasTalking.SMS;
// const options = {
//   to: ["+2348071357875", "+2349041757710"],
//   message: "I'm a lumberjack and its ok, I work all night and sleep all day",
// };

// sms
//   .send(options)
//   .then((response) => {
//     console.log(response);
//   })
//   .catch((error) => {
//     console.log(error);
//   });
    
// const num = '+2347053225992'
// createMessage('THIS IS TESTING TWILIO',num)

app.use(
  "/api/v1/auth",
  upload.single("profilePicture"),
  require("./routes/auth")
);

app.use("/api/v1/auth", require("./routes/verifyEmail"));
app.use("/api/v1/ussd", require("./routes/ussd"));
app.use(verifyJWT);

app.use(permissions);
app.use("/api/v1/user", require("./routes/user"));
app.use("/api/v1/station", require("./routes/station"));
app.use(
  "/api/v1/crime",
  upload.fields([
    { name: "profilePicture", maxCount: 1 },
    { name: "photo", maxCount: 1 },
    { name: "video", maxCount: 1 },
    { name: "audio", maxCount: 1 },
    { name: "file", maxCount: 1 },
    { name: "image", maxCount: 1 },
  ]),
  require("./routes/crime")
);
app.use(
  "/api/v1/incident",
  upload.fields([
    { name: "profilePicture", maxCount: 1 },
    { name: "photo", maxCount: 1 },
    { name: "video", maxCount: 1 },
    { name: "audio", maxCount: 1 },
    { name: "file", maxCount: 1 },
    { name: "image", maxCount: 1 },
  ]),
  require("./routes/incident")
);
app.use("/api/v1/emergency", require("./routes/emergency"));
app.use("/api/v1/sos", require("./routes/SOS"));
app.use("/api/v1/blog/post", upload.single("image"), require("./routes/post"));
app.use(
  "/api/v1/blog/comment",
  upload.single("image"),
  require("./routes/comment")
);

app.use("*", (req, res) => {
  res.send("<h1>ROUTE NOT FOUND</h1>");
});

app.use(errorHandler);

mongoose.connection.once("open", () => {
  console.log("connected to mongoDB");
  app.listen(PORT, console.log(`server running on ${PORT}`));
});



mongoose.connection.on("error", (err) => {
  console.log(err);
});

module.exports = cloudinary;