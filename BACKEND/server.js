require("dotenv").config();
const express = require("express");
const app = express();
const multer = require("multer");
const connectDB = require("./config/dbConn"); // Import the database connection file
const mongoose = require("mongoose");
const errorHandler = require("./middleware/errorHandler");
const permissions = require("./middleware/permissions");
const verifyJWT = require("./middleware/verifyJWT");

const PORT = process.env.PORT || 3500;

// Connect to MongoDB
connectDB();

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// middleware
app.use(express.json());

// routes
app.get("/", (req, res) => {
  res.send("index route");
});

// app.use(
//   upload.fields([
//     { name: "profilePicture", maxCount: 1 },
//     { name: "photo", maxCount: 1 },
//     { name: "video", maxCount: 1 },
//     { name: "audio", maxCount: 1 },
//     { name: "file", maxCount: 1 },
//     { name: "image", maxCount: 1 },
//   ])
// );

app.use(
  "/api/v1/auth",
  upload.single("profilePicture"),
  require("./routes/auth")
);

app.use(verifyJWT);
app.use(permissions);
app.use("/api/v1/user", require("./routes/user"));
app.use("/api/v1/crime", require("./routes/crime"));
app.use("/api/v1/incident", require("./routes/incident"));
app.use("/api/v1/emergency", require("./routes/emergency"));
app.use("/api/v1/blog/post", upload.single("image"), require("./routes/post"));

app.use("/*", (req, res) => {
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