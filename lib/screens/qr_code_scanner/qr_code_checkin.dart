import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:korean_words/korean_words.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/count_down_timer.dart';

class QRCodeCheckIn extends StatefulWidget{
  @override
  _QRCodeCheckInState createState() => _QRCodeCheckInState();
}

class _QRCodeCheckInState extends State<QRCodeCheckIn> with TickerProviderStateMixin{

  AnimationController animationController;
  bool hasTimerStopped = false;
  String frontMockWord = "";
  String backMockWord = "";

  String personalNumber = "";
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(seconds: 30));
    frontMockWord = getRandomString(30);
    backMockWord = getRandomString(30);

    print(frontMockWord);
    print(backMockWord);

    String word = generateKoreanWords(wordCount: 2).take(1).toString();
    String firstLetter = word[1];
    String lastLetter = word[word.length-2];
    print(firstLetter);
    print(lastLetter);
    int otpNumber = 10 + Random().nextInt(99 - 10);

    personalNumber = otpNumber.toString() + firstLetter + (99-otpNumber).toString() + lastLetter;

  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: TextTitleAppBar(title: "QR코드 체크인",),
     body: SingleChildScrollView(
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(height: 40,),
             Text("입장을 위한 QR코드",style: AppThemes.textTheme.headline1,textAlign: TextAlign.center,),
             SizedBox(height:20),
             Text("이용하려는 시설의 담당자에게 QR코드를 보여주거나\n개인 안심번호를 수기출입명부에 기재하세요.",textAlign: TextAlign.center,
             style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.grey,height: 1.5)),
             SizedBox(height: 30,),
             Container(
               width: 300,
               height: 350,
               child: Card(
                 elevation: 2,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(6.0)
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          Icon(Icons.access_time_outlined,size: 20,),
                         SizedBox(width: 10,),
                         Text("남은 시간",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),),
                         new CountDownTimer(
                             controller :animationController,
                             whenTimeExpires: () {
                               setState(() {
                                 print("AAAAAA");
                                 hasTimerStopped = true;
                               });
                             },
                             secondsRemaining: 30,
                             countDownTimerStyle: AppThemes.textTheme.bodyText1.copyWith(
                               color: Colors.black)
                         )
                       ],
                     ),

                     qrCode(hasTimerStopped),
                     SizedBox(height: 10,),
                     Visibility(
                       visible: hasTimerStopped ? false : true,
                       child: RichText(
                         text: TextSpan(text: '개인안심번호  ',style : AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),
                             children:[
                           TextSpan(text: personalNumber,style : AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700)),

                         ]),
                       ),
                     ),
                   ],
                 ),
               ),
             ),
             SizedBox(height:50),
             GestureDetector(
               behavior: HitTestBehavior.opaque,
               onTap: () => refreshWidget(),
               child: Container(
                 width: 150,
                 height: 60,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(6.0),
                     color: AppThemes.mainColor,
                     border: Border.all(color: AppThemes.mainColor)
                 ),
                 alignment: Alignment.center,
                 child: Text("새로 고침",style: AppThemes.textTheme.bodyText1.copyWith(color: Colors.white),),

               ),
             )

                        ],
         ),
       ),
     ),

   );
  }


  Widget qrCode(bool isTimerStopped){
    if(isTimerStopped){
      return GestureDetector(
        onTap: () => refreshWidget(),
        child: Container(
          width: 200,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Icon(Icons.refresh_outlined,size:  50,),
              SizedBox(height: 40,),
              Text("유효시간이 지났습니다.\nQR코드를 재생성 해주세요.",style: AppThemes.textTheme.bodyText1.copyWith(height: 1.5),textAlign: TextAlign.center,),
            ],
          ),
        ),
      );
    }else{
      return GestureDetector(
        onTap: () {
          print(hasTimerStopped);
          print(frontMockWord);
          print(backMockWord);



        },
        child: QrImage(
          data: frontMockWord + "여기가 User UID 들어갈 자리" + backMockWord,
          version: QrVersions.auto,
          size: 200.0,
        ),
      );
    }
  }


  void refreshWidget(){
    setState(() {
      hasTimerStopped = false;

      frontMockWord = getRandomString(30);
      backMockWord = getRandomString(30);

      print(frontMockWord);
      print(backMockWord);

      String word = generateKoreanWords(wordCount: 2).take(1).toString();
      String firstLetter = word[1];
      String lastLetter = word[word.length-2];
      print(firstLetter);
      print(lastLetter);
      int otpNumber = 10 + Random().nextInt(99 - 10);

      personalNumber = otpNumber.toString() + firstLetter + (99-otpNumber).toString() + lastLetter;

      animationController.stop();
      animationController.dispose();
      animationController = new AnimationController(vsync: this,duration: Duration(seconds: 30));
      animationController.reverse(from: 30.0);
      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          setState(() {
            print("AAAAAA");
            hasTimerStopped = true;
          });
        }
      });

    });
  }








}