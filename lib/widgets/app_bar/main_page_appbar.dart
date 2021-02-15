import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/notice_page/notice_list_page.dart';

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
      actions: [InkWell(
          onTap:()=> Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeListPage()),
          ),
          child: Icon(Icons.notifications_outlined)
          //알림 없을때는 - Icons.notification_none_outlined 있을때는 Icons.Notification_on_outlined

      )],
      title:  Text(title,style: AppThemes.textTheme.headline1),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70.0);



}