import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/send_marketing_push/local_widget/add_new_fcm_button.dart';
import 'package:shoppingapp/screens/send_marketing_push/local_widget/fcm_list_item.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class CustomPushList extends StatefulWidget{
  @override
  _CustomPushListState createState() => _CustomPushListState();
}

class _CustomPushListState extends State<CustomPushList>{
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title:"푸시메세지 설정"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child:Image.asset("assets/images/set_fcm_page/advertising.png",fit: BoxFit.cover,),),
                SizedBox(width: 40,),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("매력적인 메세지로\n고객들을 유도해봐요!",style: AppThemes.textTheme.headline1,),
                )
              ],
            ),
            SizedBox(height: 60),
            Text("설정된 푸시메세지 목록",textAlign: TextAlign.start,style : AppThemes.textTheme.headline1.copyWith(fontSize: 15)),
            SizedBox(height: 10),
            //목록에 새로 추가하기
            AddNewFCMButton(),
            //현재 저장되어 있는 Item
            FCMListItem(),
          ],
        ),
      ),

    );
  }

}