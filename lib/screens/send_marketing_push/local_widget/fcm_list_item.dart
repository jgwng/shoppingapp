import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class FCMListItem extends StatefulWidget{
  @override
  _FCMListItemState createState() => _FCMListItemState();
}

class _FCMListItemState extends State<FCMListItem>{
  bool clicked = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          clicked = !clicked;
        });
      },
      child:  Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
                color: AppThemes.mainColor,width: 2
            )
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("어서오세요"),
                    Text("가입해주셔서 감사합니다.")
                  ],),
                Icon(clicked ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined ,size: 35,),
              ],
            ),
            SizedBox(height: 10,),
            if(clicked)
              Text("추가하기",textAlign: TextAlign.center,style: AppThemes.textTheme.headline1.copyWith(fontSize: 18),)
          ],
        ),
      ),
    );
  }

}