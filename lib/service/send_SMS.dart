import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

int makeOTPNumber(){
    int otpNumber = 100000;
    otpNumber = 100000 + Random().nextInt(999999 - 100000);
    return otpNumber;
  }

  //Naver Cloud PlatForm - Simple & EasyNotification Service 이용
  void sendSMS(String phoneNumber, int otpNumber) async{
    String timeStamp = (DateTime.now().millisecondsSinceEpoch).toString();
    Map data = {
      "type":"SMS",
      "contentType":"COMM",
      "countryCode":"82",
      "from":"01041290741",
      "content" : "  ",
      "messages":[
        {
          "to":phoneNumber,
          "content":"Gunny마켓 휴대폰 인증번호 [$otpNumber] 위 번호를 인증 창에 입력하세요."
        }
      ],
    };


    var result = await http.post(
        "https://sens.apigw.ntruss.com/sms/v2/services/${Uri.encodeComponent('ncp:sms:kr:262932458188:plan20_practice')}/messages",
        headers: <String, String>{
          "accept" : "application/json",
          'content-Type': 'application/json; charset=UTF-8',
          'x-ncp-apigw-timestamp' :timeStamp,
          'x-ncp-iam-access-key': 'FAQsCnhfmyZSQ7SGHfXe',
          'x-ncp-apigw-signature-v2' : getSignature(Uri.encodeComponent('ncp:sms:kr:262932458188:plan20_practice'),timeStamp,
              'FAQsCnhfmyZSQ7SGHfXe', '1aFPKgdGB7IxXQrdaaU3SoXemEnXpHveD1jPwRB6')
        },
        body: json.encode(data)
    );
    print(result.body);
  }

  String getSignature(
      String serviceId, String timeStamp, String accessKey, String secretKey) {
    var space = " "; // one space
    var newLine = "\n"; // new line
    var method = "POST"; // method
    var url = "/sms/v2/services/$serviceId/messages";

    var buffer = new StringBuffer();
    buffer.write(method);
    buffer.write(space);
    buffer.write(url);
    buffer.write(newLine);
    buffer.write(timeStamp);
    buffer.write(newLine);
    buffer.write(accessKey);
    print(buffer.toString());

    /// signing key
    var key = utf8.encode(secretKey);
    var signingKey = new Hmac(sha256, key);

    var bytes = utf8.encode(buffer.toString());
    var digest = signingKey.convert(bytes);
    String signatureKey = base64.encode(digest.bytes);
    return signatureKey;
 }
