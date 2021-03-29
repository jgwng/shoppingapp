import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/coupon.dart';
import 'package:intl/intl.dart';

class CheckCouponDialog extends StatefulWidget{
  CheckCouponDialog({Key key, this.coupon}) : super(key: key);
  final Coupon coupon;

  @override
  _CheckCouponDialogState createState() => _CheckCouponDialogState();
}

class _CheckCouponDialogState extends State<CheckCouponDialog>{
  bool buttonClicked = false;
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Coupon couponInfo = widget.coupon;
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 10),
      title: Text("입력한 쿠폰 정보 확인",style:AppThemes.textTheme.bodyText1),
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
                   SizedBox(height:20),
                   couponInfoItem("쿠폰 이름", couponInfo.couponTitle),
                   SizedBox(height:10),
                   couponInfoItem("유효기간", conversionDateTime(couponInfo.expiredDate)),
                   SizedBox(height:10),
                   couponInfoItem("할인율(할인금액)", (couponInfo.discountAmount<1) ? "${couponInfo.discountAmount}%" :"${couponInfo.discountAmount}원" ),
                   SizedBox(height:10),
                   couponInfoItem("최소 주문 금액", "${couponInfo.minOrderAmount}원"),
                   SizedBox(height:30),

                 ],
               ),
              ),
              Text("위의 정보가 입력하신\n쿠폰의 정보와 일치합니까?",textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1,),
              SizedBox(height:20),
              Row(children: [
                dialogActionButton("확인"),
                dialogActionButton("취소"),

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

  Expanded dialogActionButton(String text){
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          bool result = (text == "확인") ? true : false;
          Navigator.pop(context,result);
        },
        child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.black),
                  right: BorderSide(color: (text == "확인") ? Colors.black : Colors.transparent))
          ),

          child: Text(text,textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1,),
        ),
      ));
  }
  String conversionDateTime(DateTime dateTime){
    DateTime arriveDate = DateTime(dateTime.year,dateTime.month,dateTime.day+2);
    String newFormat = DateFormat("YY년 MM월 dd일").format(arriveDate);

    return newFormat;
  }


 void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


}