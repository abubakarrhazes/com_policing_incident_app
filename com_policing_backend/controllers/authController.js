const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcrypt');
const  jwt = require('jsonwebtoken');


/* Regsiter User */

const register = async (req, res) => {

    try{
        const { firstName, lastName, otherName, email, phoneNumber, password } = req.body;
        const existingUser = await User.findOne({email : email });
        if(existingUser){
            return res.status(404).json({msg: " This User  Already Exist"});

        }
            const salt = 10;
            const hashedPassword = await bcrypt.hash(password, salt);
            const newUser =  new User({
            firstName,
            lastName,
            otherName,
            email,
            phoneNumber,
            password: hashedPassword,
        });
        const savedUser = await newUser.save();
         res.json({msg : "Account created Successfully"});


    }catch(err){

       return res.status(500).json({err: err.message});


    }


}

const login = async  (req, res) => {
    try{
        const {email , password } = req.body;
        const user = await User.findOne({email: email});
        if(!user){
            return res.status(400).json({msg: ` User With this Email does not Exist` });
        }
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch){
            return res.status(400).json({msg: `Incorect Password ` });

        }

        const token = jwt.sign({id: user.id }, process.env.JWT_SECRET_KEY);
        delete user.password;

        res.status(200).json({token, ...user._doc});

    }catch(err){
        res.status(500).json({err: err.message});

    }







}

const getUsers = async (req, res) => {
    

   



}



module.exports = {register,login, getUsers};



