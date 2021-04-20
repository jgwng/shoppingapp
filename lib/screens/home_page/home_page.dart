import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/widgets/product_item.dart';
import 'package:shoppingapp/widgets/app_bar/main_page_appbar.dart';
import 'package:shoppingapp/models/product.dart';

class HomePage extends StatefulWidget{
  HomePage({this.onPush});
  final Function onPush;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<String> categoryList =AppText.categoryList;
  List<SelectStringModel> categoryModel = List<SelectStringModel>();

  TextStyle priceStyle = AppThemes.textTheme.bodyText1.copyWith(fontSize: 14);
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryModel = List.generate(categoryList.length,(i) => SelectStringModel(text: categoryList[i],isSelected:(i == 0)?true:false));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title: 'Gunny',),
      body:  NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll){
        overScroll.disallowGlow();
        return;
        },
          child : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text("이번주 인기 상품",style: AppThemes.textTheme.headline1),
            SizedBox(height: 15,),
            Container(
                height: 120,
                width: double.infinity,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.separated(
                    itemCount: 3,
                    itemBuilder: (ctx,i) => bestProductListItem(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (ctx,i) =>SizedBox(width: 20,),
                  ),
                )
            ),
            SizedBox(height: 40,),
            Text("이번주 할인 상품",style: AppThemes.textTheme.headline1),
            SizedBox(height: 5,),
            Container(
                height: 35,
                width: double.infinity,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.separated(
                    itemCount: categoryModel.length,
                    itemBuilder: (ctx,i) => categoryListItem(categoryModel[i]),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (ctx,i) =>SizedBox(width: 20,),
                  ),
                )
            ),
            SizedBox(height: 10,),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  crossAxisCount:2,
                  childAspectRatio: 140/200,
                  crossAxisSpacing: 23.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  children: List.generate(8, (index){
                    return ProductItem(onPush : widget.onPush);
                  })
              ),
            )

          ],
        ),
      )
      ),
    );
  }


  Widget bestProductListItem(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onPush(Product()),
      child: Container(
        height: 120,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: AppThemes.mainColor)
        ),
        child: Row(

          children: [
            Container(
                padding: EdgeInsets.only(left: 15),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("상품평수 1위!",style: AppThemes.textTheme.subtitle1,),
                    SizedBox(height: 40,),
                    Text("챔피온 티셔츠",style: AppThemes.textTheme.bodyText1),
                    Text("15000원",style: priceStyle)
                  ],
                )
            ),
            SizedBox(width: 25,),
            SizedBox(
              width: 95,
              height: 95,
              child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.cover,),),



          ],
        ),
      ),
    );
  }
  
  Widget categoryListItem(SelectStringModel selectModel){
    return GestureDetector(
      onTap: (){
        setState(() {
          categoryModel.forEach((element) => element.isSelected = false);
          selectModel.isSelected = true;
        });
      },child:Container(
      width: 90,
      height: 10,
      child: Card(

        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selectModel.isSelected ? AppThemes.mainColor : Colors.white70, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child:Center(
              child : Text(
                selectModel.text,textAlign: TextAlign.center,
                style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 16),
              ),
            )
        ),
      ),
    ),
    );
  }

}