import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class CouponListPage extends StatefulWidget{
  @override
  _CouponListPageState createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage>{
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "쿠폰함",),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(width: 20,),
            Text("보유쿠폰 1장", style: AppThemes.textTheme.bodyText2.copyWith(
            color: AppThemes.inActiveColor
            )),
          ],),

        SizedBox(height: 10,),
        Center(child:Stack(
          children: [
            Container(
              width: double.infinity,

              padding: EdgeInsets.symmetric(horizontal: 30),
              child:Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 15,top: 10,bottom: 10),
                  child: Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      Text("10000원",style:  AppThemes.textTheme.subtitle1.copyWith(fontSize: 40),),
                      SizedBox(height: 50,),
                      //쿠폰 제목
                      Text("2월 월간 쿠폰",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 22)),
                      //쿠폰 유효 기간
                      couponInfo("유효기간 : ", "2021년 02월 18일"),
                      couponInfo("최소 주문 금액 : ", "15000원"),

                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 35,
              bottom: 8,
              child: Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/images/coupon_list_page/checkmark.png'),
              ),
            ),

          ],
        ),)
      ],
    ),
    );
  }



  Widget couponInfo(String title, String value){
    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(text : title,style: AppThemes.textTheme.bodyText2.copyWith(fontSize: 14)),
              TextSpan(text : value,style: boldStyle),
            ]));
  }
}