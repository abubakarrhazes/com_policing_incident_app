const express = require('express');

const authRouter = express.Router();
const {register, login, getUsers} = require('../controllers/authController.js');




authRouter.post('/register', register);

authRouter.post('/login', login);

authRouter.get('/get', getUsers);



module.exports =  authRouter;