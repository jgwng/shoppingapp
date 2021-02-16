import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCheck extends StatefulWidget{
  @override
  _OrderCheckState createState() => _OrderCheckState();
}

class _OrderCheckState extends State<OrderCheck>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40,top: 80),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(width: 2, color: AppThemes.mainColor)),
            child: Container(
                width: 320,
                height: 160,
                padding: EdgeInsets.only(left: 20,right: 20,top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("주문을 한 날짜입니다.",style: AppThemes.textTheme.bodyText1,),
                        Row(
                          children: [
                            Text("상세보기",style: AppThemes.textTheme.bodyText2.copyWith(color: AppThemes.inActiveColor),),
                            Icon(Icons.arrow_forward_ios,color: AppThemes.inActiveColor,)

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Divider(color: AppThemes.mainColor,),
                    SizedBox(height: 2,),
                    Text("현재 배송 상태를 표시"),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 60,height: 60,child: Image.asset('assets/logo/grocery-cart.png',fit: BoxFit.fill,alignment: Alignment.center,)),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("주문 금액 : ",style: AppThemes.textTheme.headline1),
                                Text("15000원",style: AppThemes.textTheme.bodyText1),
                              ],
                            ),

                          ],
                        )

                      ],
                    ),
                    SizedBox(height: 5,),

                  ],
                )
            )
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://www.doortodoor.co.kr/parcel/pa_004.jsp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}