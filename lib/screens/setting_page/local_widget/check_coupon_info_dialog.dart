import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class CheckCouponDialog extends StatefulWidget{
  @override
  _CheckCouponDialogState createState() => _CheckCouponDialogState();
}

class _CheckCouponDialogState extends State<CheckCouponDialog>{
  bool buttonClicked = false;
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);
  List<String> couponNoticeList = ["최소 15,000원 이상 주문시 사용가능합니다.","다른 쿠폰과 중복 사용하실 수 없습니다.","쿠폰은 다른 계정으로 양도할 수 없습니다."];
  Alignment alignment = Alignment.bottomCenter;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 10),
      title: Text("입력한 쿠폰번호 확인",style:AppThemes.textTheme.bodyText1),
      content: Container(
        width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment : CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   couponInfoItem("쿠폰 이름", "2월 정기 쿠폰"),
                   couponInfoItem("쿠폰 이름", "2월 정기 쿠폰"),
                   couponInfoItem("쿠폰 이름", "2월 정기 쿠폰"),
                   couponInfoItem("쿠폰 이름", "2월 정기 쿠폰"),
                 ],
               ),
              ),
             
              Row(children: [
                Expanded(child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black)
                    ),
                  ),
                ),),
                Expanded(child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black),
                    ),
                  ),
                ),),
              ],)
            ],
          ),
      )
    );
  }

  Widget couponInfoItem(String label, String content){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,style: AppThemes.textTheme.bodyText1,),
        Text(content,style: AppThemes.textTheme.headline1.copyWith(color: AppThemes.pointColor),)
      ],
    );
  }





 void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


}