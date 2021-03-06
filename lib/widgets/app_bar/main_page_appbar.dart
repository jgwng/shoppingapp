import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/notice_icon.dart';
import 'package:shoppingapp/screens/order_cart_page/order_cart_page.dart';

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
      leading: NoticeIcon(),
      centerTitle: true,
      actions: [InkWell(
          onTap:()=> Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderCartPage(),
          )),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.shopping_cart_outlined,color: Colors.black,size: 30,),
          )
          //알림 없을때는 - Icons.notification_none_outlined 있을때는 Icons.Notification_on_outlined
          ),
      ],
      title:  Column(
        children: [
          SizedBox(height: 5,),
          Text(title,style: (title == "Gunny") ? GoogleFonts.permanentMarker(fontSize: 30,color: Colors.black)
              : AppThemes.textTheme.bodyText1.copyWith(fontSize: 23,color: Colors.black))
        ],
      ),
    );
  }




  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);



}