import 'package:http/http.dart' as http;
import 'dart:convert';

void sendEmail() async{
  var result = await http.post(
      "https://asia-northeast3-shopping-app-2d3ec.cloudfunctions.net/sendEmail",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data' : {
          'dest' :'gunwng123@gmail.com',
          'subject': 'aaaa',
          'text': 'aaaaaa',
        }
      })
  );
  print(result.body);
}