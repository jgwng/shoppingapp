import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:flutter/gestures.dart';
import 'package:shoppingapp/widgets/keypad.dart';
import 'package:shoppingapp/widgets/count_down_timer.dart';
import 'package:shoppingapp/service/send_SMS.dart';
class PhoneVerification extends StatefulWidget{
  PhoneVerification({Key key, this.phoneNumber,this.initOTP}) : super(key: key);
  final String phoneNumber;
  final int initOTP;
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> with TickerProviderStateMixin{
  String otpNumber = "";
  String inputOTP  = '';

  AnimationController animationController;
  bool hasTimerStopped = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 300));
    otpNumber = widget.initOTP.toString();
  }

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
                text: TextSpan(text: '${widget.phoneNumber}',style : AppThemes.textTheme.bodyText1.copyWith(
                    color: AppThemes.pointColor,fontSize: 30
                ),children:[
                  TextSpan(text: '으로 전송된\n인증번호를 입력해 주세요.',style : AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,height: 1.5))
                ]),
              ),
            ),
            SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width:30),
            Text("남은 시간",style : AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700)),
            CountDownTimer(
                controller :animationController,
                whenTimeExpires: () {
                  setState(() {
                    print("AAAAAA");
                    hasTimerStopped = true;
                  });
                },
                secondsRemaining: 300,
                countDownTimerStyle: AppThemes.textTheme.subtitle1.copyWith(
                    color: AppThemes.pointColor)
            )
          ],),
          SizedBox(height: 90,),
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
            SizedBox(height: 75,),

            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: '인증번호가 도착하지 않았나요?   ',style : AppThemes.textTheme.bodyText1.copyWith(
                    color: Colors.black,fontSize: 14
                ),children:[
                  TextSpan(text: '재전송하기.',style : AppThemes.textTheme.bodyText1.copyWith(color: AppThemes.pointColor),recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {

                      animationController.stop();
                      animationController.dispose();
                      animationController = new AnimationController(vsync: this,duration: Duration(seconds: 300));
                      animationController.reverse(from: 300.0);
                      int newOTPNumber = makeOTPNumber();
                      sendSMS("01041290741",newOTPNumber);
                      otpNumber = newOTPNumber.toString();

                    });
                  }),
                ]),
              ),
            ),
            SizedBox(height: 80,),
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
      if(inputOTP== otpNumber){
        animationController.stop();
        animationController.dispose();
        Navigator.pop(context);
      }else{
        setState(() {
          inputOTP = "";
        });
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