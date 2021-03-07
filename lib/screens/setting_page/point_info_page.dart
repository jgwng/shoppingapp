import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class PointInfoPage extends StatefulWidget{
  @override
  _PointInfoPageState createState() => _PointInfoPageState();
}

class _PointInfoPageState extends State<PointInfoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "적립금",),
    );
  }

}