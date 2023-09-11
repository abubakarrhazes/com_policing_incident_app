const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    firstName: {
        required : true,
        type : String,
        

    }, 
    lastName: {
        required : true,
        type : String,
        

    }, 
    otherName: {
        required : true,
        type : String,
        

    }, 
    dateOfBirth: {
        type: Date,
        default : '',
    },
    email : {
        required: true,
        type: String,
        trim: true,
        validate : {
            validator : (value) => {
                const regex = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i
                return value.match(regex);
            },
            message: 'Please Enter Valid Email',
        }
    },
    address :{
        type: String,
        default: ''
    },
    ninNumber :{
        type: String,
        default: ''
    },
    phoneNumber :{
        required : true,
        type: String,
        default: ''
    },
    password : {
        required: true,
        type: String,
    },
    passwordComfirmation: {
        required: true,
        type: String,
    },
    stateOfOrigin: {
        type: String,
        trim : true,
        default: ''
    },
    
    userRole : {
        type : String,
        default : 'user',
    }


});


const User = mongoose.model('User', userSchema);
module.exports = User;