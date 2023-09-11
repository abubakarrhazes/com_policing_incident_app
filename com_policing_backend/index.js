const express = require('express');
const mongoose = require('mongoose');
const bodyparser = require('body-parser');
const authRouter = require('./routes/auth.js');
const userRoutes = require('./routes/user.js');
const reportRouter = require('./routes/report.js');
const verifyToken = require('./middlewares/verify.js');
const dotenv = require('dotenv');




const PORT = 8080;

const app = express();
dotenv.config();

//Middlewares
app.use(express.json());
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({extended: true}));
app.use('/api/auth', authRouter);
app.use('/api/user', userRoutes);
app.use('/api/report', reportRouter);





//Database Connection
mongoose.connect(process.env.MONGO_DB, {
  
}).then(()=>{
  console.log("Connected Succesfully");


}).catch(e =>{

  console.log(e);

});

app.listen(PORT, "0.0.0.0", ()=>{

console.log(`Connected on Port http:localhost: ${PORT}`);
})
