import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/auth_page/auth_page.dart';
import 'package:shoppingapp/screens/intro_page/Intro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';
import 'package:shoppingapp/screens/register_page/user_register_page.dart';
import 'package:shoppingapp/screens/select_page/select_page.dart';


class LandingPage extends StatefulWidget{
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Future<SharedPreferences> init;

  initialize(BuildContext context) {
    // size

    // SharedPreferences
    return SharedPreferences.getInstance();
  }

  Future<int> getCurrentUser() async {


    sizeIsNotZero(Stream<double>.periodic(
        Duration(milliseconds:200),
            (x) => MediaQuery.of(context).size.width));
    size = MediaQuery.of(context).size;
    paddingTop = MediaQuery.of(context).padding.top;
    paddingBottom = MediaQuery.of(context).padding.bottom;
    availableHeight =
        size.height - paddingTop - paddingBottom;

    if(FirebaseAuth.instance.currentUser == null) {
      return -1;
    }else{
      int result = await context.read(firestoreProvider).getUserState();
      print('Result : $result');
      return result;}
    }

  @override
  void initState() {
    super.initState();
    initialize(context);
  }
  @override
  void dispose() {
    super.dispose(); // always call super for dispose/initState

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: FutureBuilder(
            future: getCurrentUser(),
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
                 int result = snapshot.data;
                return data(context, result); // 로그인 화면
              }
              return IntroPage();
            }
        )
    );
  }
  Widget data(context, int result){
    switch(result){
      case -1:
        return AuthPage();
        break;
      case 0:
        return UserRegisterPage();
      case 1:
        return Container();
        break;
      case 2:
        return SelectOnOrOff();
        break;
    }
    return Container();
  }
}