import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class TextTitleAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  TextTitleAppBar({this.title});


  @override
  Widget build(BuildContext context) {
   return  AppBar(

       automaticallyImplyLeading: false,
       titleSpacing: 0,
       leading:Theme(
           data: ThemeData(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent,
           ),
           child: IconButton(onPressed: (){
             Navigator.pop(context);
           },
             icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
           )),
       backgroundColor: Colors.white,
       elevation: 0,
       centerTitle: true,
       title:  Text(title,style: AppThemes.textTheme.headline1),
     );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);



}