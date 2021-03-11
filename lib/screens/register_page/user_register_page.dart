import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:shoppingapp/constants/app_themes.dart';

import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/user.dart';
import 'package:shoppingapp/screens/main_page.dart';
import 'package:shoppingapp/screens/register_page/admin_notice_dialog.dart';
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

  String postNumber = '';
  String firstAddress = '검색을 통해 주소를 입력하세요';
  bool gender = false;
  int genderValue = -1;
  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  DateTime age;
  num birthYear;
  String birthMD;
  String birthday = "생년월일을 입력하세요.";
  User user = User();
  bool verifyAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TextTitleAppBar(title:"회원 가입"),
     body:NotificationListener<OverscrollIndicatorNotification>(
         onNotification: (OverscrollIndicatorNotification overScroll){
         overScroll.disallowGlow();
         return;
        },child : GestureDetector(
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
             upperInfoField(nameController,nameFocusNode,"닉네임",validateName,false,"닉네임"),
             SizedBox(height:30),
             upperInfoField(phoneNumberController,phoneNumberFocusNode,"(-) 없이",validatePhoneNumber,true,"휴대폰 번호"),
             SizedBox(height:30),
             _inputBirthDay(),
             SizedBox(height:30),
             _selectGender(),
             SizedBox(height:30),
             inputAddress(),
             SizedBox(height:20),
             GestureDetector(
               behavior : HitTestBehavior.opaque,
               onTap: () async{
                 if(!verifyAdmin){
                   bool result = await showDialog(
                       context: context,
                       builder: (BuildContext context){
                         return AdminNoticeDialog();
                       }
                   );
                   if(result){
                     setState(() {
                       verifyAdmin = !verifyAdmin;
                     });
                   }
                 }else{
                   setState(() {
                     verifyAdmin = !verifyAdmin;
                   });
                 }
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
             lowerInfoField(adminVerifyNumberController,adminVerifyNumberFocusNode,"관리자 번호",validatePhoneNumber,3),


           ],
         ),
       ),
     ),
     )),
      bottomNavigationBar: Container(
        width: 80,
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),

        child:RaisedButton(
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),

          ),
          onPressed: () async{
            // user.userToken = await FirebaseMessaging.instance.getToken();
            Navigator.push(context,MaterialPageRoute(builder:(c) => MainPage()));
          },
          child: Text("정보 입력",style: textStyle.copyWith(color: Colors.white,fontSize: 18),),
        ),
      ),
   );
  }
  Widget lowerInfoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,Function(String number) function,int index){
    return Column(
      children: [
        Container(
            height: 50,
            padding: (index == 3) ? EdgeInsets.symmetric(horizontal: 8) : EdgeInsets.only(left:20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color:Colors.grey)
            ),
            //이름
            child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                style:TextStyle(color: Colors.black),
                keyboardType: (index == 3) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(

                  prefixIcon: (index == 3) ? Icon(Icons.supervisor_account) : null,
                  suffixIcon: ((index == 3)) ? GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text("번호 인증",style: textStyle,),
                    ),
                  ) : null,
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
        ),
        SizedBox(height: 10,),
      ],
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
                                child: Text(hintText == "관리자 번호" ? "번호 인증" : "인증번호 전송",style: textStyle,),
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

  Widget inputAddress(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("주소",style: textStyle,),
        SizedBox(height:10),
        Row(
          children: [
            Container(
              width: 80,
              height:40,
              alignment : Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey),
                  borderRadius: BorderRadius.circular(6.0)
              ),
              child: Text(postNumber,style : textStyle),
            ),
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
        ),
        SizedBox(height: 10),
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey,width: 1)
          ),
          alignment : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(firstAddress,style: textStyle,textAlign: TextAlign.left,),
        ),
        SizedBox(height: 10),
        lowerInfoField(secondAddressController,secondAddressFocusNode,"나머지 주소",validatePhoneNumber,2),
        Text("* 해당 주소는 기본 배송지로 설정됩니다.",textAlign: TextAlign.left,style: textStyle.copyWith(color:AppThemes.mainColor,fontSize: 12),)
      ],
    );
  }


  Widget _selectGender(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
            child:  Text("성별",style: textStyle,)),
        SizedBox(width: 20,),
        Expanded(

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
        SizedBox(width:8),
        Text(
          genderText,
          style:TextStyle( color: Color.fromRGBO(42, 42, 42, 1.0)
             ),
        )
      ],
    );
  }






}