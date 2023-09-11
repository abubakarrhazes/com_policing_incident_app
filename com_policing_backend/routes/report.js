const express = require('express');
const {reportCrime, getAllReportCrime} = require('../controllers/reportController.js');
const reportController = require('../controllers/reportController.js');
const verifyToken = require('../middlewares/auth.js');

const reportRouter = express.Router();

reportRouter.post('/userReport', reportCrime);


reportRouter.get('/getAllReport', getAllReportCrime);



module.exports = reportRouter;