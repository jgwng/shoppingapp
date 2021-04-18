import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/models/question.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';
import 'package:shoppingapp/service/send_email.dart';
class OneOnOneQuestion extends StatefulWidget {
  @override
  _OneOnOneQuestionState createState() => _OneOnOneQuestionState();
}

class _OneOnOneQuestionState extends State<OneOnOneQuestion> {
  FocusNode questionFocusNode = FocusNode();
  FocusNode mailFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
  bool isFocused = false;
  bool isCompleted = true;

  double _inputHeight = 170;
  String email;
  final questionTitleController = TextEditingController(); // 질문 제목 textfield 컨트롤러
  final questionContentController = TextEditingController(); //  질문 내용 textfield 컨트롤러


  final _infoFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Question question = Question();
  TextStyle privacyTextStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w400,fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));
  TextStyle textStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w500,fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));
  @override
  void initState() {
    super.initState();

    // User user  = context.read(userStateProvider).currentUser;
    questionContentController.addListener(_checkInputHeight);
    questionContentController.addListener(_onFocusChange); // 엔터 여부 확인 위해 설정
  }

  @override
  void dispose() {
    questionTitleController.dispose();
    questionContentController.dispose();
    super.dispose();
  }

  void _onFocusChange() async {
    setState(() {
      isFocused = !isFocused;
    });
  }

  void _checkInputHeight() async {
    int count = questionContentController.text.split('\n').length; // 사용자의 엔터 입력 확인
    if (count == 0 && _inputHeight == 170.0) {
      return;
    }
    if (count <= 5) {
      // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 170.0 : 28.0 + (count * 28.0);
      setState(() {
        _inputHeight = newHeight;
      });
    } // 사용자의 엔터 입력에 따른 질문 내용의 textfield 크기 증가 & 감소
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TextTitleAppBar(
            title: "1:1 문의하기"
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll){
            overScroll.disallowGlow();
            return;
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => unFocus(),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal:24.0),
                child: Form(
                  key: _infoFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: widgetHeight(40),),
                      questionNTitleField("제목", questionTitleController, questionFocusNode, "제목을 입력해주세요.", validateTitle),
                      //Text "제목" & 일대일 질문 제목
                      SizedBox(height: widgetHeight(22.5),),
                      contentField(),
                      SizedBox(height: widgetHeight(25.5),),
                      Divider(height: 2.0, color: Colors.black),
                      SizedBox(height: widgetHeight(24.36),),
                      //개인정보 수집 및 이용동의 체크 부분
                      checkPrivacyNNotice(),
                      SizedBox(height: widgetHeight(30),),
                      Container(
                        width: 160,
                        height: 40,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(6.0)
                        ),
                        child: RaisedButton(
                          color:AppThemes.mainColor,
                          onPressed: onPressed,
                          child: Center(
                            child: Text("문의 전송",textAlign: TextAlign.center,style: textStyle.copyWith(color: Colors.white),),
                          ),
                        ),
                      )

                      // 작성한 질문 회사로 보내는 버튼
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));

  }

  Widget questionNTitleField(
      String frontText,
      TextEditingController controller,
      FocusNode focusNode,
      String hintText,
      Function(String number) function) {
    return Row(
      children: <Widget>[
        Text(
          frontText,
          style: textStyle,
        ),
        SizedBox(
          width: widgetWidth(22.5),
        ),
        Flexible(
          child: TextFormField(
              validator: function,
              focusNode: focusNode,
              onChanged: colorChange,
              controller: controller,
              keyboardType: TextInputType.text,
              style: textStyle,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                hintStyle: textStyle,
                hintText: hintText,
              )),
        )
      ],
    );
  }

  Widget contentField() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 25.5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(142, 142, 147, 0.24),
        border: Border.all(color: Color.fromRGBO(204, 204, 204, 1.0), width: 1),
        borderRadius: BorderRadius.circular(5.0),
      ), //내용부분 UI
      child: TextFormField(
        onChanged: colorChange,
        focusNode: contentFocusNode,
        style: textStyle,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        minLines: 7, //
        maxLines: 10, //최대 줄수 설정을 통한 줄바꿈 횟수 제한
        controller: questionContentController,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15)),
      ),
    );
  }

  Widget checkPrivacyNNotice() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: CustomCheckBox(
                radius: Radius.circular(3),
                borderColor: Colors.black,
                value: question.privacyCheck,
                checkColor: Colors.white,
                activeColor: AppThemes.mainColor,
                onChanged: (value) => checkBoxTap(value), //체크시 개인정보 수집 및 이용 동의
              ),
            ),
            SizedBox(
              width: widgetWidth(11.25),
            ),
            GestureDetector(
              onTap: () => checkBoxTap(!question.privacyCheck),
              child: Text("개인정보 수집 및 이용 동의",
                  style: privacyTextStyle),
            )
          ],
        ),
        SizedBox(
          height: widgetHeight(120),
        ),
        Container(
            width: size.width,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(204, 204, 204, 1.0), width: 1),
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(228, 228, 228, 1.0)),
            padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
            child: Text(
                "문의하신 내용은 검토하여 최대한 빠른 시일 내에\n답변을 드리도록 하겠습니다.",
                style: privacyTextStyle)), // 질문 제출시 답변 기한 관련 내용
        SizedBox(
          height: widgetHeight(24.36),
        ),
      ],
    );
  }

  void checkBoxTap(bool value) async{
    setState(() {
      question.setPrivacy(value);
      colorChange("");
      unFocus();
    });
  }

  void onPressed() async {
    if (isCompleted) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          sendEmail();
        }
        Navigator.pop(context,);
      } catch (e) {
        Navigator.pop(context);
      }
    }
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      colorChange("");
    }
  }

  void colorChange(String text) {
    setState(() {
      if ((_infoFormKey.currentState.validate()) ) {
        // & (mailController.text != "")
        isCompleted = true;
      } else {
        isCompleted = false;
      }
    });
  }
}