import 'package:flutter/cupertino.dart';

class Question with ChangeNotifier{
  String uid;
  int replyState; //0 - 읽지 않음, 1 - 읽음 , 2 - 답장 완료
  String title;
  String content;
  String replyToken;
  bool privacyCheck;
  DateTime createdAt;

  Question({this.uid,this.replyState,this.title, this.content, this.replyToken, this.createdAt,this.privacyCheck : false});

  void setPrivacy(bool secret) {
    privacyCheck = secret;
    notifyListeners();
  }

}