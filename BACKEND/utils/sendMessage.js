const expressAsyncHandler = require("express-async-handler");

const accountSid = process.env.TWILIO_ACCOUNT_SID
const authToken = process.env.TWILIO_AUTH_TOKEN
const my_number = process.env.TWILIO_PHONE_NUMBER

const client = require('twilio')(accountSid, authToken)

const createMessage = expressAsyncHandler(async ( message, number ) => {
    const sendMessage = await client.messages.create({
        body: message,
        to: number,
        from:my_number
    })
    console.log(sendMessage.body)
})

// const MessagingResponse =
//   require("twilio").twiml.MessagingResponse;

//   app.post("/incoming-message", (req, res) => {
//     const twiml = new MessagingResponse();
//     twiml.message("Thanks for signing up!");
//     res.end(twiml.toString());
//   });


module.exports = createMessage