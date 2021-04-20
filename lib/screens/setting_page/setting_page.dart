import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/providers/user_provider/user_state_provider.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page/personal_info_page.dart';
import 'package:shoppingapp/screens/setting_page/announcement_page/announcement_list_page.dart';
import 'package:shoppingapp/screens/setting_page/ask_question_page.dart';
import 'package:shoppingapp/screens/setting_page/coupon_list_page.dart';
import 'package:shoppingapp/screens/setting_page/faq_page.dart';
import 'package:shoppingapp/screens/setting_page/grade_page.dart';
import 'package:shoppingapp/screens/setting_page/notification_setting_page.dart';
import 'package:shoppingapp/screens/setting_page/point_info_page/point_info_page.dart';
import 'package:shoppingapp/screens/setting_page/term_of_use_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/widgets/app_bar/main_page_appbar.dart';

class SettingPage extends StatefulWidget{
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>{
  List<String> itemTitle = ["알림설정","공지사항","1:1문의하기","등급 관련 안내","자주 묻는 질문","이용 약관","버전 정보 "];
  TextStyle textStyle = AppThemes.textTheme.bodyText1;

  Future fetchVersion;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVersion = getData();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: MainAppBar(title:'마이 페이지',),
     body: Consumer(builder : (context,watch,child){
        return FutureBuilder(
          future: fetchVersion,
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return buildBody(context, watch(userStateProvider));
            }
            return Center(child: CircularProgressIndicator());
          });
     }),
       );
  }





  Widget buildBody(BuildContext context, UserState userState){
  print(userState.currentUser.isMan);

    return NotificationListener<OverscrollIndicatorNotification>(
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
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => PersonalInfoPage())),
                  child: Container(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                SizedBox(width: 80,height: 80,
                                  child:Image.asset("assets/images/avatar_image/${(userState.currentUser.isMan) ? 'boy' : 'girl'}_${userState.currentUser.characterIndex}.png") ,),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30,),
                              Text("${userState.currentUser.name}님",style: AppThemes.textTheme.headline1,),
                              SizedBox(height: 10,),
                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 30,height: 30,child: Image.asset("assets/images/setting_page/quality.png"),),
                                    SizedBox(width: 10,),
                                    Text("레벨 1",style: AppThemes.textTheme.subtitle1,)
                                  ]),

                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              SizedBox(height: 50,),
                              Icon(Icons.arrow_forward_ios,size: 18,)
                            ],
                          )


                        ],
                      )
                  )
              ),
              Row(
                children: [
                  couponNPointInfo("쿠폰","10개"),
                  couponNPointInfo("적립금","13000원"),
                ],
              ),
              SizedBox(height: 15,),
              Divider(color: AppThemes.mainColor,height: 1,thickness: 1,),
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overScroll){
                  overScroll.disallowGlow();
                  return;
                },child: Container(
                height: 500,
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


              //버전정보 Container 생성
              SizedBox(height: 15,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(text: '24시간 연중무휴 고객 센터  ',style : textStyle.copyWith(
                          color: Colors.grey,fontSize: 14
                      ),children:[
                        TextSpan(text: '1234-5678',style : textStyle.copyWith(fontWeight: FontWeight.w700))
                      ]),
                    ),
                    SizedBox(height: 8,),
                    Text("CopyRight to Gunny in Daejeon, All Rights Reserved",style: AppThemes.textTheme.bodyText2.copyWith(
                        color: AppThemes.inActiveColor
                    ),textAlign: TextAlign.center),
                    SizedBox(height :30),

                  ],
                ),
              ),
              SizedBox(height: 10,),

            ]
        )));
  }


  Widget listItem(int index){
    return  Container(
        height: (index == 6 ) ? 55: 68,
        width: double.infinity,
        alignment: Alignment.center,
        child:  Row(
          children: [
            listItemIcon(index),
            SizedBox(width: 20,),
            Text(itemTitle[index],textAlign: TextAlign.center,style: AppThemes.textTheme.subtitle1.copyWith(fontSize:17,fontWeight: FontWeight.w700,height: 1.55),),
          ],
        ),

      );
  }

  Widget couponNPointInfo(String title,String content){
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => tapForPointOrCoupon(title),
        child:Container(
          height: 80,
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: (title == "쿠폰") ? AppThemes.inActiveColor : Colors.transparent,width:1),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: [
              Text(title,textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1,),
              SizedBox(height: 10,),
              Text(content,textAlign:TextAlign.center,style: AppThemes.textTheme.subtitle1.copyWith(color: AppThemes.pointColor),)
            ],
          ),
        ),
      ),
    );
  }

  Widget listItemIcon(int index){
    switch(index){
      case 0:
        return Icon(Icons.notifications_outlined);
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
        return Icon(Icons.campaign_outlined);
        break;
      case 6:
        return Icon(Icons.info_outline);
        break;
    }
    return Container();
  }
  void tapForPointOrCoupon(String title){
    Navigator.push(context,MaterialPageRoute(builder:(c) => (title == "쿠폰") ? CouponListPage() : PointInfoPage()));
  }
  void onTap(int index){
    switch(index){
      case 0:
        Navigator.push(context,MaterialPageRoute(builder:(c) => NotificationSettingPage()));
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

  Future<void> getData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    itemTitle.last = itemTitle.last + version + "+" + buildNumber;
  }

}