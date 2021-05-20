import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class ModifyInfoDialog extends StatefulWidget{
//  ModifyInfoDialog({Key key, this.coupon}) : super(key: key);
//  final Coupon coupon;

  @override
  _ModifyInfoDialogState createState() => _ModifyInfoDialogState();
}

class _ModifyInfoDialogState extends State<ModifyInfoDialog>{
  bool buttonClicked = false;
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        contentPadding: EdgeInsets.only(top: 10),
//        title: Text("입력한 쿠폰 정보 확인",style:AppThemes.textTheme.bodyText1),
        content: Container(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment : CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height:20),
              Text("수정하신 정보를\n저장하시겠습니까?",textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1.copyWith(
                height: 1.5
              ),),
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

  Expanded dialogActionButton(String text){
    return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context,(text == '확인') ? true : false),
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




}