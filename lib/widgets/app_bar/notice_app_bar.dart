
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class AnnouncementDetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TextTitleAppBar(title: "공지사항",),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text("Gunny의 서비스가 개시가 되었습니다!",style: AppThemes.textTheme.headline1,),
              SizedBox(height: 5,),
              Text("2021.02.10 ",style: AppThemes.textTheme.bodyText2.copyWith(
                  color: AppThemes.inActiveColor
              )),

              SizedBox(height: 10,),
              Divider(color: AppThemes.mainColor,height: 1,),
              SizedBox(height: 10,),
              Text("안녕하세요. (주)거니 입니다.\n\n여러분들 응원에 힘입어 거니의 서비스가 시작 되었습니다!\n앞으로 많은 이용 부탁드립니다.",
                style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 14),)
            ],
          ),
        )
    );
  }
}