import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class ProductOptionSelectPage extends StatefulWidget{
  @override
  _ProductOptionSelectPageState createState() => _ProductOptionSelectPageState();
}

class _ProductOptionSelectPageState extends State<ProductOptionSelectPage>{
  TextStyle titleStyle = AppThemes.textTheme.bodyText1.copyWith(
      fontWeight: FontWeight.w700);
  String category;
 bool isClicked = false;
  @override
  void initState() {
    // TODO: implement initState


    //PopupMenuButton 초기화 - 초기에는 전체 메일 목록 보여줌
    category = '전체';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.transparent,
     body:Column(
       children: [
         Container(
             width: 110,height: 40,
             padding: EdgeInsets.only(left: 30,right: 20),
             child:  Center(
               child: selectCategory(),
             )
         ),
         if(isClicked)
           Container(height: 300,color: Colors.pink,),
         GestureDetector(
           onTap: (){
             setState(() {
               isClicked = !isClicked;
             });
           },
           child: Container(height : 100,color: Colors.blue),)

       ],
     ),
   );
  }
  Widget selectCategory(){
    return PopupMenuButton(

      offset: Offset(-30,10),
      tooltip: '카테고리 선택',
      child: Row(
        children: [
          Text('$category',style: titleStyle,),
          SizedBox(width: 5,),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
            size: 10,
          )
        ],
      ),
      onSelected: (value) {
        setState(() {
          category = value;
        });

      },

      elevation: 10,
      itemBuilder: (_) {
        return [
          categoryItem('전체'),
          categoryItem('문의'),
          categoryItem('사료'),

        ];
      },
    );
  }

  PopupMenuItem categoryItem(String title){
    return  PopupMenuItem(

      value: title,
      child: Text(
          title,
          style: titleStyle.copyWith(color: category == title ? Colors.blue : Colors.black)
      ),
    );
  }

}