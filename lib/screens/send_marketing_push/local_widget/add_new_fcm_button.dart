import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/send_marketing_push/add_custom_push_page.dart';

class AddNewFCMButton extends StatefulWidget{
  @override
  _AddNewFCMButtonState createState() => _AddNewFCMButtonState();
}

class _AddNewFCMButtonState extends State<AddNewFCMButton>{


  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       Navigator.push(context,MaterialPageRoute(builder:(c) => AddMarketingPush()));
     },
     child:  Container(
       height: 60,
       width: double.infinity,
       alignment: Alignment.center,
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(6.0),
           border: Border.all(
               color: AppThemes.mainColor,width: 2
           )
       ),
       child:Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(Icons.loupe_rounded,size: 35,),
           SizedBox(width: 5,),
           Text("추가하기",textAlign: TextAlign.center,style: AppThemes.textTheme.headline1.copyWith(fontSize: 18),)
         ],
       )
       ,
     ),
   );
  }

}