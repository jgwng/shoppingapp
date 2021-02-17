import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class NoticeListPage extends StatefulWidget{
  @override
  _NoticeListPageState createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: TextTitleAppBar(title: "알림",),
     body:  Center(
         child: Column(
           children: [
             SizedBox(
               height: widgetHeight(241),
             ),
             Icon(Icons.notifications_off_outlined,size: 40,),
             SizedBox(height: 10,),
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