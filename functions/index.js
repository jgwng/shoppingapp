const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth:{
        user : 'petplan20.crm@gmail.com',
        pass : 'petplan0313$'
    }
});

exports.sendEmail = functions.region('asia-northeast3').https.onRequest((req, res) => {
    cors(req,res,() => {
     const dest = req.query.dest;
        console.log(res);
        console.log(req.body.dest);

        //getting dest email by query string
        // const dest = req.query.dest;
        const mailOptions = {

            to: req.body.data.dest,
            subject: req.body.data.subject,
            text:req.body.data.text,
            attachment: req.body.data.attachment
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
