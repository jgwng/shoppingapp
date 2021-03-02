import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/setting_page/announcement_list_page.dart';
import 'package:shoppingapp/screens/setting_page/ask_question_page.dart';
import 'package:shoppingapp/screens/setting_page/coupon_list_page.dart';
import 'package:shoppingapp/screens/setting_page/faq_page.dart';
import 'package:shoppingapp/screens/setting_page/grade_page.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page.dart';
import 'package:shoppingapp/screens/setting_page/term_of_use_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class SettingPage extends StatefulWidget{
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{


  List<String> itemTitle = ["쿠폰 관리","공지사항","1:1문의하기","등급 관련 안내","자주 묻는 질문","이용 약관"];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     body: NotificationListener<OverscrollIndicatorNotification>(
       onNotification: (OverscrollIndicatorNotification overScroll){
     overScroll.disallowGlow();
     return;
   },child :
     SingleChildScrollView(

       padding: EdgeInsets.symmetric(horizontal: 30),
       child: Column(
         children: [
           SizedBox(height: widgetHeight(10),),
            GestureDetector(
              onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => PersonalInfoPage())),
              child:Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: AppThemes.mainColor)),
                  child: Container(
                      width: 340,
                      padding: EdgeInsets.only(left : 18,right: 15,top:22,bottom:15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text("촉촉한 초코우유",style: AppThemes.textTheme.bodyText1,),
                              ),
                              SizedBox(
                                width: 110,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Text("개인정보 변경",style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.grey,fontSize: 15),),
                                    Icon(Icons.arrow_forward_ios,size: 15,color: AppThemes.inActiveColor,)
                                  ],
                                ),
                              )

                            ],
                          ),
                          gradeNPointInfo("등급 ", "레벨 1  "),
                          gradeNPointInfo("적립금", "35000원  "),
                        ],
                      )
                  )
              ),
            ),
           NotificationListener<OverscrollIndicatorNotification>(
             onNotification: (OverscrollIndicatorNotification overScroll){
               overScroll.disallowGlow();
               return;
             },child: Container(
             height: 440,
             child: ListView.separated(
               separatorBuilder:(ctx,i) => Divider(height: 2,color: AppThemes.mainColor,thickness:1,),
               itemCount: itemTitle.length,
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemBuilder: (ctx,i) => listItem(i),),
           ),),
           SizedBox(height: 15,),
           Text("CopyRight to Gunny in Daejeon, All Rights Reserved",style: AppThemes.textTheme.bodyText2.copyWith(
             color: AppThemes.inActiveColor
           ),),
           SizedBox(height: 10,),

            ]
           ))),

       );
  }
  Widget listItem(int index){
    return  GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 75,
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                listItemIcon(index),
                SizedBox(width: 20,),
                Text(itemTitle[index],textAlign: TextAlign.center,style: AppThemes.textTheme.subtitle1.copyWith(fontSize:17,fontWeight: FontWeight.w700,height: 1.55),),
              ],
            ),

            Icon(Icons.arrow_right_rounded,size: 30,)
          ],
        ),
      ),
    );
  }

  Widget gradeNPointInfo(String title,String content){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: AppThemes.textTheme.bodyText1),
            Text(content,style: AppThemes.textTheme.subtitle1)
          ],
        ),
      ],
    );
  }








  Widget listItemIcon(int index){
    switch(index){
      case 0:
        return Icon(Icons.style_outlined);
        break;
      case 1:
        return Icon(Icons.announcement_outlined);
        break;
      case 2:
        return Icon(Icons.support_agent_outlined);
        break;
      case 3:
        return Icon(Icons.grade_outlined);
        break;
      case 4:
        return Icon(Icons.question_answer_outlined);
        break;
      case 5:
        return Icon(Icons.info_outline);
        break;
    }
    return Container();
  }

  void onTap(int index){
    switch(index){
      //쿠폰 관리
      case 0:
        Navigator.push(context,MaterialPageRoute(builder:(c) => CouponListPage()));
        break;
      //공지사항
      case 1:
        Navigator.push(context,MaterialPageRoute(builder:(c) => AnnouncementListPage()));
        break;
      //1:1문의하기
      case 2:
        Navigator.push(context,MaterialPageRoute(builder:(c) => OneOnOneQuestion()));
        break;
      //등급 관련 안내
      case 3:
        Navigator.push(context,MaterialPageRoute(builder:(c) => GradeDetail()));
        break;
      //자주 묻는 질문
      case 4:
        Navigator.push(context,MaterialPageRoute(builder:(c) => FAQ()));
        break;
      // 이용 약관
      case 5:
        Navigator.push(context,MaterialPageRoute(builder:(c) => TermsOfUse()));
        break;
    }
  }
}