import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/animation_coupon.dart';

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
    return AlertDialog(
      title: Text("입력한 쿠폰번호 확인"),
      content: Container(
        width: 400,
        height: 180.0,
          child: Column(
            children: [
              Row(
                children: [
                  Text("쿠폰 이름"),
                  Text("aaaaaa")
                ],
              ),
              Row(
                children: [
                  Text("유효기간"),
                  Text("")
                ],
              ),
              Row(
                children: [
                  Text("할인 정도"),
                  Text("aaaaaa")
                ],
              ),
              Row(
                children: [
                  Text("최소 주문 금액"),
                  Text("aaaaaa")
                ],
              )
            ],
          ),
      ),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: RaisedButton(
                    child: const Text('OPEN'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(width: 30,),
              Container(
                width: 100,
                child: RaisedButton(
                    child: const Text('OPEN'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),

            ],
          ),
        )


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