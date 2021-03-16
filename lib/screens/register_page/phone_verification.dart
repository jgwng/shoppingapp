import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'dart:math' as math;

import 'package:shoppingapp/widgets/keypad.dart';

class PhoneVerification extends StatefulWidget{
  PhoneVerification({Key key, this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification>{
  String testNumber = "123456";
  String inputOTP  = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child:RichText(
                text: TextSpan(text: '01041290741',style : AppThemes.textTheme.bodyText1.copyWith(
                    color: Colors.grey,fontSize: 14
                ),children:[
                  TextSpan(text: '으로 전송된 인증번호를\n입력해 주세요.',style : AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700))
                ]),
              ),
            ),
            SizedBox(height: 150,),
            Center(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx,i) => otpField(i),
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (ctx,i) => SizedBox(width: 15,),
                ),
              ),
            ),
            SizedBox(height: 150,),
            KeyPad(onTap: onTap,),
          ],
        ),
      ),
    );
  }
  void onTap({String text}){

    if(text.length != 1){
      inputOTP = (inputOTP.length == 0) ? inputOTP : inputOTP.substring(0,inputOTP.length-1);
   }
   else{
      inputOTP = (text != " ") ? inputOTP + text : inputOTP;
   }
   setState(() {
    if(inputOTP.length == 6){
      if(inputOTP== testNumber){
        Navigator.pop(context);
      }else{
        print("failed");
      }
    }
   });

   print(inputOTP);


  }
  Widget otpField(int index){
    return Container(
      width: 45,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.black)
      ),
      child: Text("${(inputOTP.length<index+1 ? " " : inputOTP.substring(index, index+1))}",style: AppThemes.textTheme.bodyText1,),
    );
  }

}