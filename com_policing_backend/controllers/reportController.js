const express = require('express');
const Report = require('../models/report');
const User = require('../models/user.js');



/* Report Crime */


const reportCrime = async (req, res) => {


    try{
        const {category , detail, location} = req.body;
        const user = await User.findById(userId);
        const reportCrime = new User(Report({
            


        }))
        const CaseReported = await reportCrime.save();
        res.status(200).json({msg: 'Crime Reported Succesfully'});

    }catch(err){
        res.status(500).json({err: err.msg});

    }
}


const getAllReportCrime = async (req, res) => {

    res.send("Hola Amigo");
}



module.exports = {reportCrime, getAllReportCrime};
