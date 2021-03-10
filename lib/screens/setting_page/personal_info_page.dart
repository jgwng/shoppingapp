import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:intl/intl.dart';

class PersonalInfoPage extends StatefulWidget{
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage>{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  DateTime age;
  num birthYear;
  String birthMD;
  String birthday = "생년월일을 입력하세요.";
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 16,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title:"개인정보 변경"),
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },child: SingleChildScrollView(

        child: Center(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => showOverLay(context),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      child: Center(
                        child : SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset("assets/images/setting_page/boy.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.black)
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom:10),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent)),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text("*캐릭터를 눌러서 이미지를 변경해 보아요!",style: AppThemes.textTheme.subtitle2.copyWith(color:Colors.grey),),
                  SizedBox(height:15),
                ],
              ),
              SizedBox(height:20,child: Container(color: Colors.grey[200],),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height:30),
                    upperInfoField(phoneNumberController,phoneNumberFocusNode,"(-) 없이",validatePhoneNumber,true,"휴대폰"),
                    SizedBox(height:30),
                    _inputBirthDay(),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("자주 쓰는 배송지 관리",style: textStyle,),
                        Icon(Icons.arrow_right,size: 25,)
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("기본 환불 계좌 설정",style: textStyle,),
                        Icon(Icons.arrow_right,size: 25,)
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
          bottomNavigationButton("로그 아웃"),
          bottomNavigationButton("회원 탈퇴"),
          ],

        ),
      ),

    );
  }

  Widget upperInfoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,Function(String number) function,bool verification,String label){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label,style: textStyle),
        ),
        SizedBox(width: 20,),
        Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color:Colors.grey)
            ),
            child : TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                style:TextStyle(color: Colors.black),
                keyboardType: (verification) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 2,
                    minHeight: 2,
                  ),

                  suffixIcon: (verification) ? GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text(hintText == "관리자 번호" ? "번호 인증" : "번호 변경",style: textStyle,),
                    ),
                  ) : null,

                  contentPadding: EdgeInsets.only(left:20,bottom:3),
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                )
            )
        ),),

      ],
    );
  }

  Widget _inputBirthDay(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child:  Text("생년월일",style: textStyle,)),
          SizedBox(width: 20,),
          Expanded(

              child: GestureDetector(
                onTap: () async {
                  age = await onBirthdayPickerBottomSheet(context);
                  if(age !=null){
                    setState(() {
                      birthYear = age.year;
                      String month = age.month.toString().padLeft(2, '0');
                      String day = age.day.toString().padLeft(2,'0');
                      birthMD = month + day;
                      birthday = DateFormat('yyyy년 MM월 dd일').format(age);
                    });
                  }

                },
                child: Container(
                  height: 50,

                  padding: EdgeInsets.only(left:20),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(birthday,textAlign: TextAlign.center,style: (birthday != "생년월일을 입력하세요.") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
                  textStyle.copyWith(color:Colors.grey)),
                ),
              )
          ),
        ]
    );
  }

  Expanded bottomNavigationButton(String text){
    return Expanded(
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(6.0)
              ),
              child: RaisedButton(
                color: AppThemes.mainColor,
                onPressed: (){},
                child: Text(text,style: AppThemes.textTheme.bodyText1.copyWith(color:Colors.white),),
              ),
    ));
  }

  void showOverLay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry topOverlay = OverlayEntry(
        maintainState: false  ,
        builder: (context) {
          return Positioned(
              top: 100.0,
              right: 0.0,
              child: Material(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        boxShadow: [BoxShadow(blurRadius: 5.0)]),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Show page")),
                    ),
                  )));
        });
    overlayState.insert(topOverlay);
    await Future.delayed(Duration(seconds: 2));
    topOverlay.remove();
  }
  //Overlay data 전달 관련
  //https://medium.com/@saiaparna.kunala/flutter-overlay-for-filtering-7000e3ac4f16
//https://github.com/flutter/flutter/issues/50961


}