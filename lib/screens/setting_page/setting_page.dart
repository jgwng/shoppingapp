import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/setting_page/ask_question.dart';
import 'package:shoppingapp/screens/setting_page/grade_page.dart';
import 'package:shoppingapp/screens/setting_page/term_of_use.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class SettingPage extends StatefulWidget{
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
  List<String> itemTitle = ["등급 관련 안내","1:1문의하기","쿠폰 관리","자주 묻는 질문","이용 약관"];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: TextTitleAppBar(title: "개인정보 설정"),
     body: SingleChildScrollView(
       padding: EdgeInsets.symmetric(horizontal: 30),
       child: Column(
         children: [
            SizedBox(height: 20,),
            Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: AppThemes.mainColor)),
                 child: Container(
                     width: 320,
                     padding: EdgeInsets.all(20),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("촉촉한 초코우유",style: AppThemes.textTheme.bodyText1,),
                             Icon(Icons.arrow_forward_ios)
                           ],
                         ),
                         SizedBox(height: 5,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("등급 ",style: AppThemes.textTheme.bodyText1),
                             Text("레벨 1  ",style: AppThemes.textTheme.headline2.copyWith(fontSize: 22))
                           ],
                         ),
                         SizedBox(height: 5,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("적립금",style: AppThemes.textTheme.bodyText1),
                             Text("35000원  ",style: AppThemes.textTheme.headline2.copyWith(fontSize: 22))
                           ],
                         ),
                       ],
                     )
                 )
             ),
           Container(
             height: 500,
             child: ListView.separated(
               separatorBuilder:(ctx,i) => Divider(height: 2,color: AppThemes.mainColor,thickness:1,),
               itemCount: itemTitle.length,
               shrinkWrap: true,
               itemBuilder: (ctx,i) => listItem(i),),
           )
            ]
           )),
       );
  }
  Widget listItem(int index){
    return  GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 80,
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(itemTitle[index],textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1,),
            Icon(Icons.arrow_right_rounded,size: 30,)
          ],
        ),
      ),
    );
  }

  void onTap(int index){
    switch(index){
      //등급 관련 안내
      case 0:
        Navigator.push(context,MaterialPageRoute(builder:(c) => GradeDetail()));
        break;
      //1:1 문의하기
        case 1:
        Navigator.push(context,MaterialPageRoute(builder:(c) => OneOnOneQuestion()));
        break;
      //쿠폰 관리
      case 2:
        Navigator.push(context,MaterialPageRoute(builder:(c) => SettingPage()));
        break;
      //자주 묻는 질문
        case 3:
        Navigator.push(context,MaterialPageRoute(builder:(c) => SettingPage()));
        break;
      // 이용 약관
      case 4:
        Navigator.push(context,MaterialPageRoute(builder:(c) => TermsOfUse()));
        break;
    }
  }
}