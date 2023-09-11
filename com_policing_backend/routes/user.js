const express = require ('express');
const { getAllReportCrime } = require('../controllers/reportController.js');

const {updateUser , deleteUser } = require('../controllers/userController.js');


const userRoutes = express.Router();

//Update User Route 


userRoutes.put('/:id', updateUser);


//Delete User Route


userRoutes.delete('/:id', deleteUser);


//Get All Users Accounts

userRoutes.get('/getAll-users', getAllReportCrime)




module.exports = userRoutes;


