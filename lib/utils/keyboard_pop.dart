import 'package:flutter/cupertino.dart';

keyboardDown(BuildContext context) async {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  await Future.delayed(Duration(milliseconds: 400));
}