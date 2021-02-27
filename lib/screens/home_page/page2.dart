import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/home_page/product_list_page.dart';
import 'package:shoppingapp/widgets/category_item.dart';

class Page2 extends StatefulWidget{
  @override  
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            //가운데(2,2) - 2번째줄 2번째 Item
            Container(
              alignment: Alignment(0.32,0.093),
              child: categoryItem("유니섹스"),
            ),
            //(2,1)
            Container(
              alignment: Alignment(-0.515,0.093),
              child: categoryItem("카테고리"),
            ),
            //(2,3)
            Container(
              alignment: Alignment(1.15,0.093),
              child: categoryItem("카테고리"),
            ),
            //(3,1)
            Container(
              alignment: Alignment(-0.098,0.52),
              child: categoryItem("카테고리"),
            ),
            //(3,2)
            Container(
              alignment: Alignment(0.75,0.52),
              child: categoryItem("카테고리"),
            ),
            //(1,1)
            Container(
              alignment: Alignment(-0.098,-0.33),
              child: categoryItem("카테고리"),
            ),
            //(1,2)
            Container(
              alignment: Alignment(0.73,-0.335),
              child: categoryItem("카테고리"),
            ),
          ],
        ),
      ),
      );
  }

  Widget categoryItem(String title){
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => ProductListPage(category: title,))),
      child: Container(
        width: 100,
        height: 100,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
                width: 100,
                height: 100,
                child: HexagonPaint(Offset(0,0),70)
            ),
            Positioned(
              right: 74,
              bottom: 80,
              child: Container(
                  width: 60,
                  height: 60,
                  child: Image.asset("assets/logo/grocery-cart.png")
              ),
            ),

            Container(
              alignment: Alignment(-2.2,-0.35),
              child: Text(title,style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 15),),
            ),


          ],
        ),
      ),
    );
  }




}