import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
class DataNonePage extends StatefulWidget{
  DataNonePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DataNonePageState createState() => _DataNonePageState();
}

class _DataNonePageState extends State<DataNonePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: (widget.title == null) ? TextTitleAppBar(title : "알림") : null,
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 200,height: 200,
              child: Image.asset("assets/images/data_none_page/unicorn.png",fit: BoxFit.cover),),
            SizedBox(height: 40,),
            Text(
              widget.title,textAlign: TextAlign.center,
              style: AppThemes.textTheme.headline1.copyWith(
                  fontSize: 25,height: 1.5),
            ),
            SizedBox(height: 100,)
          ],
        ),
      )
    );
  }

}