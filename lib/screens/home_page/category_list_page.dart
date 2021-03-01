import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/screens/home_page/product_list_page.dart';
import 'package:shoppingapp/widgets/category_item.dart';

class CategoryList extends StatefulWidget{
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>{
  List<String> categoryList = AppText.categoryList;
  //["유니섹스","여성","남성","가방 잡화","슈즈","뷰티"];

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
              child: categoryItem("카테고리",""),
            ),
            //(2,1)
            Container(
              alignment: Alignment(-0.515,0.093),
              child: categoryItem("남성","braces"),
            ),
            //(2,3)
            Container(
              alignment: Alignment(1.15,0.093),
              child: categoryItem("여성","dress"),
            ),
            //(3,1)
            Container(
              alignment: Alignment(-0.098,0.52),
              child: categoryItem("슈즈","sneakers"),
            ),
            //(3,2)
            Container(
              alignment: Alignment(0.745,0.515),
              child: categoryItem("뷰티","fragance"),
            ),
            //(1,1)
            Container(
              alignment: Alignment(-0.098,-0.33),
              child: categoryItem("유니섹스","hoodie"),
            ),
            //(1,2)
            Container(
              alignment: Alignment(0.73,-0.335),
              child: categoryItem("가방잡화","cap"),
            ),
          ],
        ),
      ),
      );
  }

  Widget categoryItem(String title,String imageName){
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
              right: 72,
              bottom: 50,
              child:Container(


                child: Column(
                  children: [
                    Container(
                        width: 65,
                        height: 60,
                        padding: EdgeInsets.only(left: 5),
                        child: (imageName == "") ? Image.asset("assets/logo/grocery-cart.png") : Image.asset("assets/images/category_icon/$imageName.png")
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(title,style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 15),textAlign: TextAlign.center,),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }




}