import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/setting_page/ask_question_page.dart';
import 'package:shoppingapp/screens/setting_page/grade_page.dart';
import 'package:shoppingapp/screens/setting_page/setting_page.dart';

class FAQListItem {
  String question;
  Widget answer;
  String type;

  bool isSelected;
  FAQListItem(this.type,this.question,this.answer,{this.isSelected = false});
}

List<FAQListItem> faqList(BuildContext context){
  TextStyle answerStyle = AppThemes.textTheme.bodyText1.copyWith(color:Color.fromRGBO(42, 42, 42, 1.0));
  TextStyle linkStyle = answerStyle.copyWith(color:AppThemes.pointColor,decoration: TextDecoration.underline,
    decorationColor: AppThemes.pointColor,);
  List<FAQListItem> faqQuestionList = [
    FAQListItem("", "", Text("")),

    //등급 질문
    FAQListItem("등급","등급은 언제 업데이트 되나요?",Text("등급은 전월 실적을 바탕으로 하여 다음 달 1일에 갱신이 됩니다.",style: answerStyle,)),
    FAQListItem("등급","등급 변경 기준이 무엇인가요?",RichText(
      text: TextSpan(text: '정확한 등급 변경 기준은 등급 확인 페이지에 상세히 나와있습니다. ',style : answerStyle,children:[
        TextSpan(text: '하단 탭 - 설정(톱니바퀴 모양) - 등급 관련 안내',style : linkStyle, recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GradeDetail()));
          }),
        TextSpan(text: "에서 물음표 모양의 아이콘을 탭하시면 보실 수 있습니다.",style : answerStyle,),
      ]),
    )),
    FAQListItem("고객문의","앱을 사용하다가 오류를 발견하였어요",RichText(
      text: TextSpan(text: '',style : answerStyle,
          children:[
            TextSpan(text: '하단 탭 - 설정(톱니바퀴 모양) - 1:1문의하기',style : linkStyle,
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OneOnOneQuestion()));}),
            TextSpan(text: "을 통해 해당 오류에 관해 자세하게 알려주시면 검토 후 소정의 상품을 드리도록 하겠습니다. 앱 이용에 불편을 드려 죄송합니다.",style : answerStyle,),
          ]),
    )),
    FAQListItem("기타","앱 알람을 끄고 싶어요",RichText(
      text: TextSpan(text: '',style : answerStyle,
          children:[
            TextSpan(text: '하단 탭 - 설정(톱니바퀴 모양) - 상단의 카드 모양',style : linkStyle,
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));}),
            TextSpan(text: "을 터치하여 개인정보 페이지에서 푸시메세지 알림 설정하고 끄실 수 있습니다.",style : answerStyle,),
          ]),
    ))
  ];



  return faqQuestionList;
}
