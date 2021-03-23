import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class GradeDetail extends StatefulWidget{
  @override
  _GradeDetailState createState() => _GradeDetailState();
}

class _GradeDetailState extends State<GradeDetail>{
  List<String> imageAddress =['grade_1.png','grade_2.png','grade_3.png','grade_4.png','grade_5.png'];
  List<int> gradeAmountList = [50,100,200,300,500];
  TextStyle noticeStyle = AppThemes.textTheme.subtitle2.copyWith(color: Color.fromRGBO(96, 96, 96, 1.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title: "등급 안내",),
      body:  NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding : EdgeInsets.symmetric(horizontal : 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.asset('assets/images/grade_page/grade_1.png',fit: BoxFit.cover,),
                  ),
                   SizedBox(width: 50,),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       SizedBox(height: 30,),
                       Text('이번달 회원님의 등급',style : AppThemes.textTheme.bodyText1),
                       Text('레벨 1\n',style : AppThemes.textTheme.headline1.copyWith(color: AppThemes.pointColor)),
                       Text('이번달 결제 금액',style : AppThemes.textTheme.bodyText1),
                       Text('30000원\n',style : AppThemes.textTheme.headline1.copyWith(color: AppThemes.pointColor)),
                     ],
                   )
                ],
              ),),
            SizedBox(height: 20,),
            Text('전체 등급 목록',style: AppThemes.textTheme.bodyText1.copyWith(color: Colors.grey),),
            Container(
              height: 660,
              child: ListView.separated(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx,i) => gradeItem(i),
                separatorBuilder:(ctx,i) =>  Divider(height: 2,color: AppThemes.mainColor,thickness: 1,),
              ),
            ),
            SizedBox(height: 20,),
            gradeNotice(),

          ],
        ),
      )),
    );
  }


  Widget gradeItem(int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: SizedBox(
                height: 65,
                width: 65,
                child: Image.asset('assets/images/grade_page/'+imageAddress[index]),
              ),
            ),
            SizedBox(height: 10,),
            Text("레벨 ${index+1}",style: AppThemes.textTheme.bodyText1,),
            SizedBox(height: 10,),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("조건",style : AppThemes.textTheme.subtitle1),
            SizedBox(height: 3,),
            gradeCondition('전월', ' ${gradeAmountList[index]}만원 이상 ', ' 주문'),
            SizedBox(height: 10,),
            Text("혜택",style : AppThemes.textTheme.subtitle1),
            SizedBox(height: 3,),
            gradeCondition('적립금', ' ${(index+1)*10000}원', ' 지급')


          ],
        )
      ],
    );
  }


  Widget gradeCondition(String firstText,String number, String secondText){
    return RichText(
      text: TextSpan(text: firstText,style : AppThemes.textTheme.bodyText1.copyWith(color: Colors.grey
      ),children:[
        TextSpan(text: number,style : AppThemes.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700,color: AppThemes.pointColor)),
        TextSpan(text: secondText,style : AppThemes.textTheme.bodyText1.copyWith(color: Colors.grey))
      ]),
    );
 }

  Widget gradeNotice(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("등급 유의사항",style: AppThemes.textTheme.headline1.copyWith(fontWeight: FontWeight.w700),),
        SizedBox(height: 20,),
        Text('- 회원등급은 매월 1일 오전중에 갱신됩니다\n   (1일이 휴일인 경우 첫번째 영업일 오전 중 반영)',style: noticeStyle,),
        SizedBox(height: 10,),
        Text('- 회원 등급은 전월 결제 금액에 따라 결정됩니다.',style: noticeStyle),
        SizedBox(height: 10,),
        Text('- 결제 금액은 포인트/쿠폰 등 할인 금액을 제외한\n   실제 금액입니다.',style: noticeStyle),
        SizedBox(height: 10,),
        Text('- 회원 등급별 혜택 및 산정 기준은 사전 통지 후\n   변경 될 수 있습니다.',style: noticeStyle,),
        SizedBox(height: 20,),


      ],
    );
  }







}