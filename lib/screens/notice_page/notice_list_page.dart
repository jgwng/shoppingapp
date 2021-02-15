import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';

class NoticeListPage extends StatefulWidget{
  @override
  _NoticeListPageState createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body:  Center(
         child: Column(
           children: [
             SizedBox(
               height: widgetHeight(241),
             ),
             Icon(Icons.notifications_off_outlined),
             Text(
               "알림이 없습니다.",
               style: AppThemes.textTheme.headline2.copyWith(
                   fontSize: 21, color: AppThemes.inActiveColor),
             ),
           ],
         )),
   );
  }

}