import 'dart:io';


import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/providers/firebase_auth_provider.dart';
import 'package:shoppingapp/providers/platform_auth_provider.dart';
class AuthPage extends ConsumerWidget {

  final signInModelProvider = ChangeNotifierProvider<SignInViewModel>(
          (ref) => SignInViewModel(auth: ref.watch(firebaseAuthProvider)));

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final signInModel = watch(signInModelProvider);
    return ProviderListener(
        onChange: (context, model)async{
          if(model.error != null){
            print(model.error);
          }
        }, provider: signInModelProvider, child: AuthPageContent(model: signInModel,));
  }
}


class AuthPageContent extends StatelessWidget{
  final SignInViewModel model;
  AuthPageContent({Key key, this.model}) : super(key: key);

  getDeviceInfo(){
    var deviceInfo;
    if(Platform.isAndroid){
      deviceInfo = DeviceInfoPlugin().androidInfo;
    }
    if(Platform.isIOS){
      deviceInfo = DeviceInfoPlugin().iosInfo;
    }

    return deviceInfo;
  }

  @override
  Widget build(BuildContext context) {
    List<String> iconList = ["callback.png","google.png","kakaotalk.png"];
    List<String> iconNameList = ["전화번호", "구글 이메일","카카오톡"];

    isKakaoTalkInstalled();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset("assets/images/auth_page/supermarket.png",fit: BoxFit.fill,),
            ),
            SizedBox(height: 32,),
            Text("Gunny",textAlign: TextAlign.left,
              style: GoogleFonts.permanentMarker(fontSize: 60,color: Colors.black),),
            SizedBox(height: 50,),
            Container(
              width: 270,
              padding: EdgeInsets.symmetric(vertical: 17.5,),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black,width:2),
                  )),//
              child: Text("아래 계정으로 시작하기",
                  textAlign: TextAlign.center,style: AppThemes.textTheme.headline1.copyWith(fontSize: 14)),
            ),
            SizedBox(height: 10,),
            Container(
              height: 200,
              width: 270,
              child: ListView.separated(
                  itemCount: 3,
                  padding: EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  separatorBuilder: (ctx,i) => SizedBox(height: 20,),
                  itemBuilder: (context, index) {
                    return _loginItem(iconList[index],iconNameList[index],context);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginItem(String assetName, String iconName,BuildContext context){
    return GestureDetector(
      onTap:() {
        onPressed(iconName,context);
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 35.5),
        decoration: BoxDecoration(
        color: Colors.indigo[300],
          borderRadius: BorderRadius.circular(6.0)
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Image.asset("assets/images/auth_page/$assetName"),
            ),
            SizedBox(width:11.3,),
            Text(iconName,style: AppThemes.textTheme.headline1.copyWith(fontSize: 20,color: Colors.white),)
          ],
        ),
      ),
    );
  }


  void onPressed(String text,BuildContext context) async{
    switch(text){

      case "전화번호":
        print("전화번호");
       await model.signInWithPhone();
       break;
      case "구글 이메일":
        await model.signInWithGoogle();
        break;
      case "카카오톡":
        await model.signInWithKakao();
        break;
    }
  }


}

