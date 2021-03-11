import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/home_page/product_list_page.dart';

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
      backgroundColor: Colors.white,
      body:SingleChildScrollView(

        child: Stack(
          children: [
            Container(
             padding: EdgeInsets.only(top: 95),
              child: Row(
                children: [
                  SizedBox(width: 65,),
                  categoryItem("유니섹스","hoodie"),
                  categoryItem("가방잡화","cap"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top:210),
              child: Row(
                children: [
                  categoryItem("남성","braces"),
                  categoryItem("카테고리",""),
                  categoryItem("여성","dress"),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 325),
              child: Row(
                children: [
                  SizedBox(width: 65,),
                  categoryItem("슈즈","sneakers"),
                  categoryItem("뷰티","fragance"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(String title,String imageName){
    return GestureDetector(
        onTap: () {
          if(title != "카테고리")
          Navigator.push(context,MaterialPageRoute(builder:(c) => ProductListPage(category: title,)));
        },
        child:
        Padding(
          padding: EdgeInsets.all(8.0),
          child: HexagonWidget.pointy(
            height: widgetHeight(150),
            cornerRadius: 12.0,
            color: Colors.brown[200],
            child: Container(
              padding: EdgeInsets.only(top: 20,right: 5),
              child: Column(
                children: [
                  Container(
                      width: 65,
                      height: 60,
                      child: (imageName == "") ? Image.asset("assets/logo/grocery-cart.png") : Image.asset("assets/images/category_icon/$imageName.png")
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(title,style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 15),textAlign: TextAlign.center,),
                  ),

                ],
              ),
            )
            ,
          ),
        ));
  }




}