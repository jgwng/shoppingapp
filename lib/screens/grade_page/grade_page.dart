import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/widgets/text_title_appbar.dart';

class GradeDetail extends StatefulWidget{
  @override
  _GradeDetailState createState() => _GradeDetailState();
}

class _GradeDetailState extends State<GradeDetail>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TextTitleAppBar(title: "등급 안내",),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/grade_page/grade_1.png',fit: BoxFit.fill,),
                  ),
                  Text("현재 촉촉한초코우유님은\n초보자 등급 입니다.")
              ],
            ),
            )

          ],
        ),
      ),
    );
  }

}