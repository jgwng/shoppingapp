const functions = require("firebase-functions");
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
admin.initializeApp();

const msg = {
    android : {
           notification : {
           },
       },
        apns : {
           payload : {
               aps : {
                   sound : "default",
                    alert : {

                   },
               }
           },
        }
}

exports.sendFCM = functions.region('asia-northeast3').https.onCall(async (data, context)  => {
    let {title, body, target} = data;
    msg.data.title = title;
    msg.data.body = body;
    msg.android.data.title = title;
    msg.android.data.body = body;
    // msg.apns.payload.aps.alert.title = title;
    // msg.apns.payload.aps.alert.body = body;
    msg.token = target

    console.log(msg);
    var result = admin.messaging().send(msg);
    return result;
});

let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth:{
        user : 'gunwng123@gmail.com',
        pass : 'rjsdnd12!@'
    }
});

exports.sendEmail = functions.region('asia-northeast3').https.onRequest((req, res) => {
    cors(req,res,() => {
     const dest = req.query.dest;
        console.log(req.body.data.dest);
        console.log(req.body.data.subject);
        console.log(req.body.data.text);

        //getting dest email by query string
        // const dest = req.query.dest;
        const mailOptions = {

            to: req.body.data.dest,
            subject: req.body.data.subject,
            text:req.body.data.text,
             // email subject
        };

        return transporter.sendMail(mailOptions,(erro,info)=> {
            if(erro){
                return res.send(erro.toString());
            }
            return res.send('Sended');
        });

   });

});