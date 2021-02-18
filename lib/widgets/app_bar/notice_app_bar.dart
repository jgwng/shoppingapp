import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/notice_page/notice_list_page.dart';

class NoticeAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback onPressed;
  NoticeAppBar({this.title,this.onPressed});


  @override
  Widget build(BuildContext context) {
    return  AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
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
      actions: [InkWell(
          onTap:onPressed,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.delete_outline_outlined,color: Colors.black,),
          )

      )],
      title:  Text(title,style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 23,color: Colors.black)),
    );
  }




  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);



}