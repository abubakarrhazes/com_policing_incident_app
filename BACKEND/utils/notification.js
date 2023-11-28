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
const verifyEmailResponse = function (username, access_token) {
  const res = {
    body: {
      greeting: "Dear",
      signature: false,
      name: `${username}`,
      intro: "Email Verification",
      action: [
        {
          instructions:
            "To get started with COM Policing, please click the button:",
          button: {
            color: "#22BC66",
            text: "Confirm your account",
            link: `${api_url}/api/v1/auth/verify/?token=${access_token}`,
            fallback: true,
          },
        },
      ],
      outro: "Best regards,<br /> ComCop Team.",
    },
  };
  return res;
};
const resetPasswordResponse = function (username, access_token) {
  const res = {
    body: {
      greeting: "Dear",
      signature: false,
      name: `${username}`,
      intro: "Reset Password",
      action: [
        {
          instructions: "Reset Password",
          button: {
            color: "#22BC66",
            text: "Confirm your account",
            link: `${api_url}/api/v1/auth/reset/password/?token=${access_token}`,
            fallback: true,
          },
        },
      ],
      outro: "Best regards,<br /> ComCop Team.",
    },
  };
  return res;
};

// require('fs').writeFileSync('preview.html', crimeEmailBody, 'utf8');

const sendEmail = async (email, subject, message) => {
  const maxRetries = 3; // Set the maximum number of retries
  let currentRetry = 0;

  let EmailBody = mailGenerator.generate(message);

  const mailOptions = {
    from: my_email,
    to: email,
    subject: subject,
    html: EmailBody,
  };

  while (currentRetry < maxRetries) {
    try {
      const info = await new Promise((resolve, reject) => {
        transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
            console.log("Error sending email:", error);
            if (currentRetry < maxRetries) {
              currentRetry++;
              console.log(`Retrying (attempt ${currentRetry})...`);
              reject("Retry");
            } else {
              console.log("Max retries reached. Email not sent.");
              reject(error);
              // Notify someone about the failure, e.g., through another service or log
            }
          } else {
            console.log("Email sent:", info.response);
            resolve(info);
            // You can include a success callback here if needed
          }
        });
      });
      return info; // Email sent successfully, return info
    } catch (error) {
      if (error !== "Retry") {
        console.error("Error sending email:", error);
        throw CustomError("Error while sending email", error);
      }
    }
  }

  // If max retries reached without success, throw an error
  throw CustomError("Max retries reached. Email not sent.");
};




// const reportCreated = (message,email) => {
//   const body = Dear user
// }

module.exports = {sendEmail,crimeResponse,verifyEmailResponse,resetPasswordResponse}
