
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:shoppingapp/providers/register_state_provider.dart';
import 'package:shoppingapp/screens/register_page/user_register_page.dart';


class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0),()=>context.read(nowStateProvider).fetchUserState());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return buildBody(watch(registerStateProvider), context);}
            )
        ));
  }

  Widget buildBody(RegisterState registerState, BuildContext context){
    if (registerState == NowState.initialRegisterState)
      return Center(child: CircularProgressIndicator());
    if(registerState.loading)
      return Center(child: CircularProgressIndicator());
    return UserRegisterPage();
  }
}
