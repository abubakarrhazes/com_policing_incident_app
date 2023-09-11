const jwt = require ('jsonwebtoken');
const User = require ('../models/user');
const verifyToken = async (req, res, next) => {


        const authHeader = req.header.token;
        if(authHeader){
            const token = authHeader.split("")(1);
            jwt.verify(token, process.env.JWT_SECRET_KEY, async (err, user) => {
                if(err) res.status(403).json("Invalid Toke");
                req.user = user;
                console.log(user);

                next();

            })

        }
        else{
            res.status(500).json({msg: "You are restricted from performing this operation"});

        }

    
}

const verifyAndAuthorization = async (req, res, next) =>{
    verifyToken(req,res, ()=>{
        if(req.user.id == req.params.id){
            next();
        }
        else{
            res.status(403).json({msg: "You are restricted from performing this operation"});

        }

    });
}

module.exports = {verifyToken, verifyAndAuthorization};