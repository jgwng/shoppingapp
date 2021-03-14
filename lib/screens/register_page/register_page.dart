
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers/register_state_provider.dart';
import 'package:shoppingapp/screens/register_page/user_register_page.dart';
import 'package:shoppingapp/screens/main_page.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0),()=>context.read(nowStateProvider).fetchUserState());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
        body: ProviderListener(
            provider: nowStateProvider,
            onChange: (context, userState) {
              if (userState != null && userState.error != null && userState.error.isNotEmpty) {
                showDialog(context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text('Error'),
                          content: Text(userState.error));
                    });
              }},
            child: Consumer(builder: (context, watch, child){
              return buildBody(watch(registerStateProvider));}
            )
        ));
  }

  Widget buildBody(RegisterState registerState){
//    print(registerState.userState);
    if (registerState == NowState.initialRegisterState)
      return Center(child: CircularProgressIndicator());
    if(registerState.loading)
      return Center(child: CircularProgressIndicator());
    if(registerState.userState == 1)
      return Container();
    if(registerState.userState == 2)
      return MainPage();
    if(registerState.userState == 0)
      return UserRegisterPage();
    return Container();
  }
}