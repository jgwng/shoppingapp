import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class AdminNoticeDialog extends StatefulWidget{
  @override
  _AdminNoticeDialogState createState() => _AdminNoticeDialogState();
}

class _AdminNoticeDialogState extends State<AdminNoticeDialog>{
  bool buttonClicked = false;
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        contentPadding: EdgeInsets.only(top: 10),
        title: Text("관리자 번호 입력",style:AppThemes.textTheme.bodyText1),
        content: Container(
          width: 300.0,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment : CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("해당 부분은 관리자 관련 영역입니다.\n 부적절한 방식으로 접근할 경우 \n불이익을 받을 수 있습니다.\n계속 진행하시겠습니까?",textAlign: TextAlign.center,
              style: AppThemes.textTheme.bodyText1.copyWith(height: 2),),

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



  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


}