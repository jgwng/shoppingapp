import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';

import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/screens/main_page.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:kopo/kopo.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';


class PersonalInfoPage extends StatefulWidget{
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage>{

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController secondAddressController = TextEditingController();
  TextEditingController adminVerifyNumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode secondAddressFocusNode = FocusNode();
  FocusNode adminVerifyNumberFocusNode = FocusNode();

  String postNumber = '우편번호';
  String firstAddress = '검색을 통해 주소를 입력하세요';
  bool searchAddress = false;
  bool gender = false;
  int genderValue = -1;
  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15, color: Color.fromRGBO(
      42, 42, 42, 1.0));

  DateTime age;
  num birthYear;
  String birthMD;
  String birthday = "생년월일을 입력해주세요.";
  User user = User();
  bool verifyAdmin = false;

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

        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              SizedBox(height: widgetHeight(25),),
              infoField(nameController,nameFocusNode,"닉네임(최대 10자)",validateName,0),
              SizedBox(height:widgetHeight(35)),
              infoField(phoneNumberController,phoneNumberFocusNode,"(-)제외",validatePhoneNumber,1),
              SizedBox(height:widgetHeight(45)),
              _inputBirthDay(),
              SizedBox(height:widgetHeight(50)),
              Container(
                  child: Row(
                    children: [
                      Text(postNumber,style : textStyle),
                      SizedBox(width: 10,),
                      RaisedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus.unfocus();
                          KopoModel model = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Kopo(),
                              ));

                          if (model != null) {
                            setState(() {
                              postNumber = model.zonecode;
                              firstAddress = model.address;
                              FocusScope.of(context).requestFocus(secondAddressFocusNode);
                              searchAddress = true;
                            });
                          }
                        },
                        child: Text("주소 검색"),
                      )
                    ],
                  )
              ),
              SizedBox(height: widgetHeight(20)),
              Container(
                width: size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[700],width: 1)
                ),
                alignment : Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(firstAddress,style: textStyle,textAlign: TextAlign.left,),
              ),
              SizedBox(height: widgetHeight(20)),
              infoField(secondAddressController,secondAddressFocusNode,"나머지 주소를 입력해주세요",validatePhoneNumber,2),
              SizedBox(height: widgetHeight(20)),
            ],
          ),
        ),
      ),
      ),
      bottomNavigationBar: Container(
        width: 80,
        height: 80,
        padding: EdgeInsets.only(bottom: 30,left: 30,right: 30),
        child:RaisedButton(
          onPressed: () async{

          },
          child: Text("정보 입력"),
        ),
      ),
    );
  }
  Widget infoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,Function(String number) function,int index){
    return Column(
      children: [
        Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),

            //이름
            child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                readOnly: (index ==2) && !searchAddress ? true : false,
                style:TextStyle(color: Colors.black),
                keyboardType: (index == 1) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(

                  prefixIcon: selectIcon(index),
                  suffixIcon: ((index == 1) | (index == 3)) ? GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text(index == 1 ? "인증번호 전송" : "번호 인증",style: textStyle,),
                    ),
                  ) : null,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppThemes.mainColor)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppThemes.mainColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppThemes.mainColor)),
                )
            )
        ),
        SizedBox(height: 10,),
      ],
    );
  }

  Widget _inputBirthDay(){
    return Container(
      height: 50,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child:Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppThemes.mainColor))),
                  child: Text(birthday,textAlign: TextAlign.center,style: (birthday != "생년월일을 입력해주세요") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
                  textStyle),
                )
            ),
            SizedBox(
              width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child:  genderTile(1,"남"),
                  ),
                  SizedBox(
                    child:  genderTile(2,"여"),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }


  Row genderTile(int value, String genderText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomRadio(
            value: value,
            groupValue: genderValue,
            onChanged: (newValue) {
              setState(() {
                genderValue = newValue;
              });
            },
            activeColor: AppThemes.mainColor,
            backgroundColor: Colors.white,
            inactiveColor:Colors.grey
        ),

        Text(
          genderText,
          style:TextStyle( color: Color.fromRGBO(42, 42, 42, 1.0)
          ),
        )
      ],
    );
  }


  Widget selectIcon(int index){
    switch(index){
      case 0:
        return Icon(Icons.account_circle_rounded);
        break;
      case 1:
        return Icon(Icons.call);
        break;
      case 2:
        return Icon(Icons.room_rounded);
        break;
      case 3:
        return Icon(Icons.supervisor_account);
        break;

    }
    return Container();
  }



}