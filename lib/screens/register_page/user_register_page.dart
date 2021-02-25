import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/constants/app_themes.dart';

import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/screens/main_page.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:kopo/kopo.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';


class UserRegisterPage extends StatefulWidget{
  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage>{

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
  bool gender = false;
  int genderValue = -1;
  TextStyle textStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w500,fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  DateTime age;
  num birthYear;
  String birthMD;
  String birthday = "생년월일";
  User user = User();
  bool verifyAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TextTitleAppBar(title:"회원 가입"),
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
             SizedBox(height: widgetHeight(20),),
             infoField(nameController,nameFocusNode,"닉네임",validateName,0),
             SizedBox(height:20),
             infoField(phoneNumberController,phoneNumberFocusNode,"전화번호((-) 없이)",validatePhoneNumber,1),
             SizedBox(height:20),
             _inputBirthDay(),
             SizedBox(height:20),
             _selectGender(),
             SizedBox(height:20),
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
                           });
                         }
                       },
                       child: Text("주소 검색"),
                     )
                   ],
                 )
             ),
             SizedBox(height: 10),
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
             SizedBox(height: 10),
             infoField(secondAddressController,secondAddressFocusNode,"나머지 주소",validatePhoneNumber,2),
             SizedBox(height: 15),
             GestureDetector(
               onTap: () {
                 //관리자 코드 입력 주의에 대한 다이얼로그 띄우고 확인 버튼 누르면 밑에 보이기
                 setState(() {
                   verifyAdmin = !verifyAdmin;

                 });
               },
               child:  Row(
                 children: [
                   Text("관리자 인증",style : textStyle,textAlign: TextAlign.start,),
                   SizedBox(width: 5,),
                   Icon(verifyAdmin ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,size: 20,color: AppThemes.mainColor,)
                 ],
               ),
             ),
             SizedBox(height: 10),
             if(verifyAdmin)
             infoField(adminVerifyNumberController,adminVerifyNumberFocusNode,"관리자 번호",validatePhoneNumber,3),


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
            // user.userToken = await FirebaseMessaging.instance.getToken();
            Navigator.push(context,MaterialPageRoute(builder:(c) => MainPage()));
            // Navigator.push(context,MaterialPageRoute(builder: (c) =>
            //     MultiProvider(providers:[
            //       ChangeNotifierProvider(
            //         create: (ctx) => Products(),),
            //       ChangeNotifierProvider(
            //         create: (ctx) => Cart(),),
            //       ChangeNotifierProvider(
            //           create:(ctx) => Orders()),
            //     ],child : MainPage())
            //
            //
            //     ));



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
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child:  Text("생년월일",style: textStyle,)),
          SizedBox(
              width: 213,
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
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppThemes.mainColor))),
                  child: Text(birthday,textAlign: TextAlign.center,style: (birthday != "생년월일") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
                 textStyle),
                ),
              )
          ),
        ]
    );
  }
  Widget _selectGender(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child:  Text("성별",style: textStyle,)),
        SizedBox(
          width: 225,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:  genderTile(1,"남성"),
              ),
              Expanded(
                child:  genderTile(2,"여성"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row genderTile(int value, String genderText) {
    return Row(
      children: [
        CustomRadio(
            value: value,
            groupValue: genderValue,
            onChanged: (newValue) {
              setState(() {
                genderValue = newValue;
                if(newValue ==1){
                  gender = true;
                }else{
                  gender = false;
                }

              });
            },
            activeColor: AppThemes.mainColor,
            backgroundColor: Colors.white,
            inactiveColor:Colors.grey
        ),
        SizedBox(width: 9),
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