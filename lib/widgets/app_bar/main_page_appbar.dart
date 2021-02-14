import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  MainAppBar({this.title});


  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      actions: [],
      title:  Text(title,style: AppThemes.textTheme.headline1),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0);



}