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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/grade_page/grade_1.png',fit: BoxFit.fill,),
                  ),
                  Text("현재 촉촉한초코우유님은\n초보자 등급 입니다.")
              ],
            ),),
            SizedBox(height: 40,),
            Text('전체 등급 목록'),
            Container(
              height: 420,
              child: ListView.separated(
              itemCount: 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx,i) => gradeItem(i),
              separatorBuilder:(ctx,i) =>  Divider(height: 2,color: AppThemes.mainColor,),
            ),
            ),
            Text('- 회원등급은 매월 1일 오전중에 갱신됩니다.(1일이 휴일인\n  경우 첫번째 영업일 오전 중 반영)',style: TextStyle(height: 1.5),),
            Text('- 회원 등급은 저월 결제 금액에 따라 결정됩니다.',style: TextStyle(height: 1.5)),
            Text('- 결제 금액은 매월 1일부터 말일까지 배달 완료 횟수를\n기준으로 합니다.',style: TextStyle(height: 1.5))
          ],
        ),
      )),
    );
  }

  Widget gradeItem(int index){
    return Container(
      height  : 80,
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/images/grade_page/'+imageAddress[index]),
          ),
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("레벨 $index"),
                Text("사용금액 ${gradeAmountList[index]}만원 이상")
              ],
            ),
          ),
          Text("적립금 ${(index+1)*10000}원 지급",textAlign: TextAlign.center,),

        ],
      ),
    );
  }


}