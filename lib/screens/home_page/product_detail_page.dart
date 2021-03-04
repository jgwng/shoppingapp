import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'dart:math' as math;
class ProductDetailScreen extends StatefulWidget{
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin{
  int widgetIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title : "제품 상세"),
        body: ListView(
          children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 350,
              child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.contain),
            ),
            SizedBox(height: 20,),
            Text("제품 이름이 들어갈 공간입니다.",style: AppThemes.textTheme.subtitle1,),
            SizedBox(height: 10),
            Text("할인율",style: AppThemes.textTheme.bodyText1,),
            SizedBox(height: 10),
            Divider(height: 2,thickness: 1,color: AppThemes.mainColor,),
            SizedBox(height: 15,),
            Text("적립 포인트 : 100개",style: AppThemes.textTheme.bodyText1,),
            SizedBox(height: 5,),
            Text("배송비 : 없음(무료 배송!)",style: AppThemes.textTheme.bodyText1,),
            SizedBox(height: 5,),
            Text("예상 출고일 : 2월 18일",style: AppThemes.textTheme.bodyText1),
            SizedBox(height: 15),

          ],
        ),
                  StickyHeader(
                  header: Container(
                  height: 60.0,
                    color: Colors.white,

                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                      children: [
                        stickyTab("상품 설명",0),
                        stickyTab("배송/반품/고시",1),
                        stickyTab("상품 문의",2),],
                    ),
                  ),
                content: contentWidget(widgetIndex),
    ),
          Container(
            height: 700,
            color: Colors.white
          )
          ],
        )
       );

  }

  Widget stickyTab(String text,int index){
    return GestureDetector(onTap: (){
      setState(() {
        widgetIndex = index;
        print(widgetIndex);
      });
    },
      child: Container(
        width: (size.width)/3,
        height: 60,
        padding: EdgeInsets.only(bottom: 5,top: 20,left: 15,right: 15),

        child: Column(
          children: [
            Text(
              text,textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10,),
            Divider(color: (widgetIndex == index) ? Colors.black : Colors.transparent,height: 2,thickness: 1,)
          ],
        ),
      ),);
  }




  Widget contentWidget(int index){
    switch(index){
      case  0:
        return Container(color: Colors.pink,height: 600);
        break;
      case 1:
        return Container(color: Colors.black,height: 400);
        break;
      case 2:
        return Container(color: Colors.green,height: 200);
        break;
      }
      return Container();
    }

  }
