import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class NotificationSettingPage extends StatefulWidget{
  @override
  _NotificationSettingPageState createState() => _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : TextTitleAppBar(title: "알림 설정")
    );
  }

}