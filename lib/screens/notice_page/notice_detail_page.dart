import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/notice_app_bar.dart';

class NoticeDetailPage extends StatefulWidget{
  @override
  _NoticeDetailPageState createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: NoticeAppBar(title: "알림 상세 정보",onPressed: onPressed,),
       body: SingleChildScrollView(
         padding: EdgeInsets.symmetric(horizontal: 30),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 30,),
             Text("알림의 제목이 들어갈 자리입니다.",style: AppThemes.textTheme.headline1,),
             SizedBox(height: 5,),
             Text("알림이 발송된 날짜가 들어갈 자리입니다.",style: AppThemes.textTheme.bodyText2.copyWith(
                 color: AppThemes.inActiveColor
             )),

             SizedBox(height: 10,),
             Divider(color: AppThemes.mainColor,height: 1,),
             SizedBox(height: 10,),
             Text("알림에 관한 내용이 들어갈 자리입니다.",
               style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 14),)
           ],
         ),
       )



   );
  }
  void onPressed(){

   Navigator.pop(context);
  }
}