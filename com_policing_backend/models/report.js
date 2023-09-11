const mongoose = require('mongoose');

const reportSchema = mongoose.Schema({
    category: {
        required : true,
        type : String,
        

    }, 
    detail : {
        required: true,
        type: String,
        
        
    },
    location : {
        type: String,
        default : ''
    },
    image : {
       
        type: String,
        default : ''
    },
    video: {
        type: String,
        default: ''

    },
    audio:{
        type: String,
        default: ''
    },

    addFile: {
        type: Date,
        default : '',
    },



});


const Report = mongoose.model('Report', reportSchema);
module.exports = Report;