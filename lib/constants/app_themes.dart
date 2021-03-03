import 'package:flutter/material.dart';
class AppThemes{
  AppThemes._();

  static const Color mainColor = Color(0xFF8D6E63);
  static const Color pointColor = Color(0xFFF57C00);
  static const Color inActiveColor =Color.fromRGBO(174, 174, 174, 1.0);
  static const Color defaultTextColor = Color.fromRGBO(47, 46, 51, 1.0);


  static const TextTheme textTheme = TextTheme(
      headline1: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 20),
      headline2: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 22),
      subtitle1: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),
      subtitle2: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 14),
      bodyText1: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),
      bodyText2: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 12)
  );





}