const expressAsyncHandler = require("express-async-handler");
const nodemailer = require('nodemailer');
const mailGen = require('mailgen');
const { CustomError } = require("../errors/customError");
const my_email = process.env.GMAIL_ACC
const password = process.env.GMAIL_PASSWORD


const api_url = process.env.API_URL
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: my_email,
    pass: password,
  },
});


let mailGenerator = new mailGen({
  theme: "default",
  product: {
    name: "com policing incident app",
    link: `${api_url}`
  }
})

const crimeResponse = function(username,ref_num){
  const res = {
    body: {
      greeting: 'Dear',
      signature: false,
      name: `${username}`,
      intro: ["Thank you for reporting.", "Below is your Reference Number which you can use to track your case.", `<p style='color:black'>${ref_num}</p>`],
      outro: 'Best regards,<br /> ComCop Team.'
    }
  }
  return res
}
const verifyEmailResponse = function(username,access_token){
  const res = {
    body: {
      greeting: 'Dear',
      signature: false,
      name: `${username}`,
      intro: "Email Verification",
    action: [
      {
          instructions: 'To get started with COM Policing, please click the button:',
          button: {
              color: '#22BC66',
              text: 'Confirm your account',
              link: `${api_url}/auth/verify/?token=${access_token}`,
              fallback: true
          }
            }
      ],
      outro: 'Best regards,<br /> ComCop Team.'
    }
  }
  return res
}



// require('fs').writeFileSync('preview.html', crimeEmailBody, 'utf8');


const sendEmail = (email, subject, message) => {
  
  let EmailBody = mailGenerator.generate(message);

   const mailOptions = {
    from: my_email,
    to: email,
    subject: subject,
    html: EmailBody,
  };

 try {
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
      console.log('error',error)
    throw CustomError('Server Error',400)
    } else {
      console.log('Email sent:', info.response);
    }
  }); 
 } catch (error) {
    throw CustomError(error.message)
 }
}




// const reportCreated = (message,email) => {
//   const body = Dear user
// }

module.exports = {sendEmail,crimeResponse,verifyEmailResponse}
