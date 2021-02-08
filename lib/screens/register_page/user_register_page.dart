import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/providers/cart.dart';
import 'package:shoppingapp/providers/orders.dart';
import 'package:shoppingapp/providers/product_provider.dart';
import 'package:shoppingapp/screens/intro_page/IntroPage.dart';
import 'package:shoppingapp/screens/one_on_one_question_page/ask_question.dart';
import 'package:shoppingapp/screens/products_overview_screen.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:kopo/kopo.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';
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
  String birthday = "생년월일을 입력해주세요.";

  bool verifyAdmin = false;

  @override
  Widget build(BuildContext context) {
    bool focus = false;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title:  Text("회원가입",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black)),
          ),
        ),
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
             infoField(nameController,nameFocusNode,"이름을 입력해 주세요",validateName),
             SizedBox(height:10),
             _inputBirthDay(),
             SizedBox(height:10),
             infoField(phoneNumberController,phoneNumberFocusNode,"(-) 없이 입력해주세요",validatePhoneNumber),
             SizedBox(height:10),
             _selectGender(),
             SizedBox(height:10),
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
                             focus = true;
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
               width: MediaQuery.of(context).size.width,
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
             infoField(secondAddressController,secondAddressFocusNode,"나머지 주소를 입력해주세요",validatePhoneNumber),
             SizedBox(height: 10),
             Text("관리자 인증",style : textStyle,textAlign: TextAlign.start,),
             SizedBox(height: 10),
             infoField(adminVerifyNumberController,adminVerifyNumberFocusNode,"관리자 번호를 입력해주세요",validatePhoneNumber),


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
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder:(c) => IntroPage()));



            // Navigator.push(context,MaterialPageRoute(builder: (c) =>
            //     MultiProvider(providers:[
            //       ChangeNotifierProvider(
            //         create: (ctx) => Products(),),
            //       ChangeNotifierProvider(
            //         create: (ctx) => Cart(),),
            //       ChangeNotifierProvider(
            //           create:(ctx) => Orders()),
            //     ],child : ProductsOverViewScreen())
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
      FocusNode focusNode,String hintText,Function(String number) function){
    return Column(
      children: [
        Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[700],width: 1)
            ),

            //이름
            child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                style:TextStyle(color: Colors.black),
                keyboardType: (hintText == "핸드폰 번호((-) 없이)") ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_rounded),
                  suffixIcon: GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text("인증번호 전송",style: textStyle,),
                    ),
                  ),
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
  Widget _inputBirthDay(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child:  Text("생년월일",style: textStyle,)),
          SizedBox(
              width: 225,
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
                      border: Border(bottom: BorderSide(color: Color.fromRGBO(238, 238, 238, 1.0)))),
                  child: Text(birthday,textAlign: TextAlign.center,style: (birthday != "생년월일을 입력해주세요") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
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
            activeColor: Colors.black,
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






}