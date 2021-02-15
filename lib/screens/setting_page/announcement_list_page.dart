import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class AnnouncementListPage extends StatefulWidget{
  @override
  _AnnouncementListPageState createState() => _AnnouncementListPageState();
}

class _AnnouncementListPageState extends State<AnnouncementListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "공지사항"),
      body: Center(
        child: Column(

          children: [
            SizedBox(
              height: widgetHeight(235),
            ),
            Icon(Icons.speaker_notes_off_outlined,size: 90,),
            SizedBox(height: 10,),
            Text(
              "공지사항이 없습니다.",
              style: AppThemes.textTheme.headline2.copyWith(
                  fontSize: 21, color: AppThemes.inActiveColor),
            )
          ],
        ),
      ),
    );
  }

}