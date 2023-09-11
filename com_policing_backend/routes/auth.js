const express = require('express');

const authRouter = express.Router();
const {register, login, get} = require('../controllers/authController.js');




authRouter.post('/register', register);

authRouter.post('/login', login);

authRouter.get('/get', get);



module.exports =  authRouter;