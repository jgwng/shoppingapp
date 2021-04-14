import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/setting_page/announcement_page/announcement_detail_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class AnnouncementListPage extends StatefulWidget{
  @override
  _AnnouncementListPageState createState() => _AnnouncementListPageState();
}

class _AnnouncementListPageState extends State<AnnouncementListPage>{
  double itemHeight = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TextTitleAppBar(title: "공지사항"),
        body: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              Container(
                height: itemHeight*3+50,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                    itemBuilder: (ctx,i) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => AnnouncementDetailPage())),
                      child: announcementListItem("title", "createdAt"),
                    ),
                    separatorBuilder: (ctx, i) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(height: 1,thickness: 1,color: AppThemes.mainColor,),
                    ),
                    itemCount: 3),
              )
            ],
          ),
          ),
        );
  }


  Widget announcementListItem(String title,String createdAt){
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      height: itemHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(title,style: AppThemes.textTheme.headline1,),
          SizedBox(height: 5,),
          Text(createdAt,style: AppThemes.textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400))
        ],
      ),
    );
  }




}