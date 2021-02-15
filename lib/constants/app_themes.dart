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
      bodyText1: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),
      subtitle1: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 18),
      bodyText2: TextStyle(fontFamily: "SpoqaHanSansNeo",fontWeight: FontWeight.w500,color: Colors.black,fontSize: 12)
    // button: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: "AppleSDGothicNeo", color: Colors.white),
    // headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, fontFamily: "SpoqaHanSansNeo", color: defaultTextColor),
    // headline2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, fontFamily: "SpoqaHanSansNeo", color: defaultTextColor),
    // subtitle1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, fontFamily: "SpoqaHanSansNeo", color: defaultTextColor),
    // bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, fontFamily: "SpoqaHanSansNeo", color: defaultTextColor),
    // bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, fontFamily: "SpoqaHanSansNeo", color: defaultTextColor),
  );





}