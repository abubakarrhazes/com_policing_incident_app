const express = require('express');
const User = require('../models/user.js');


const updateUser = async (req, res) => {



    try{
        const updateUserById = await User.findByIdAndUpdate(req.params.id);

        return res.status(200).json({msg: "User Updated By The Id "});
    

    }
    catch(err){
        res.staus(500).json({err: err.msg});



    }


};


const deleteUser = async (req,res) =>{
    try{
        const deleteUserById =  await User.findById(req.params.id);
        res.staus(200).json({msg: "Account Deleted Succesfully"});

    }catch(err){

        res.staus(500).json({err: err.msg});




    }


}

const getAllUsers = async (req,res) =>{
    try{
        const allUsers =  await User.find({});

        return res.status(200).json({msg:"All Users Created In The Database"});

    }
    catch(err){


    }



}


module.exports = {updateUser, deleteUser, getAllUsers, };



