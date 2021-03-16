import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class KeyPad extends StatelessWidget {
  final  onTap;
  final List<String> _listViewData = [
    "1","2","3",
    "4","5","6",
    "7","8","9",
    " ","0","assets/images/register_page/delete.png",
  ];
  KeyPad({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24),
        crossAxisCount:3,
        childAspectRatio: 109/54,
        shrinkWrap: true,
        children: List.generate(12, (index){
          return _gridItem(_listViewData[index]);
        })

    );
  }
  _gridItem(String text){
    return GestureDetector(
      onTap: ()=>onTap(text : text),
      child:  Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border:Border.all(color: Colors.transparent),
          ),//       <--- BoxDecoration here
          child:Center(
            child :keyPadItem(text),
          )
      ),
    );
  }


  Widget keyPadItem(String text){
    if(text.length==1){
      return Text(
        text,
        style: AppThemes.textTheme.headline1,
      );
    }else{
      return Image.asset(text);
    }

  }



}