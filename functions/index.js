const functions = require("firebase-functions");
const admin = require('firebase-admin');

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
