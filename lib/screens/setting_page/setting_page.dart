import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/order_cart_page/order_cart_page.dart';
import 'package:shoppingapp/screens/setting_page/announcement_page/announcement_list_page.dart';
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
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => OrderCartPage())),
              child: Container(
                height: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 15,),
                                SizedBox(width: 80,height: 80,
                                child:Image.asset("assets/images/setting_page/boy.png") ,),
                                SizedBox(height: 15,),
                                Text("촉촉한초코우유",style: AppThemes.textTheme.headline1,),

                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                SizedBox(width: 30,height: 30,child: Image.asset("assets/images/setting_page/quality.png"),),
                                SizedBox(width: 10,),
                                Text("레벨 1",style: AppThemes.textTheme.subtitle1,)
                              ]),
                              SizedBox(height: 30,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 30,height: 30,child: Image.asset("assets/images/setting_page/coins.png")),
                                    SizedBox(width: 10,),
                                    Text("14,000원",style: AppThemes.textTheme.subtitle1,)
                                  ]),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              SizedBox(height: 60,),
                              Icon(Icons.arrow_forward_ios,size: 18,)
                            ],
                          )


                        ],
                      )
                  )
              ),
            Divider(color: AppThemes.mainColor,height: 1,thickness: 1,),
           NotificationListener<OverscrollIndicatorNotification>(
             onNotification: (OverscrollIndicatorNotification overScroll){
               overScroll.disallowGlow();
               return;
             },child: Container(
             height: 420,
             child: ListView.separated(
               separatorBuilder:(ctx,i) => Divider(height: 2,color: AppThemes.mainColor,thickness:1,),
               itemCount: itemTitle.length,
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               itemBuilder: (ctx,i) =>
                   GestureDetector(
                       behavior: HitTestBehavior.opaque,
                     onTap: () => onTap(i),
                   child: listItem(i))),
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
    return  Container(
        height: 68,
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