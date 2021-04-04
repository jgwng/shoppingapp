import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/screens/home_page/product_detail_page.dart';
import 'package:shoppingapp/widgets/product_item.dart';
import 'package:shoppingapp/models/product.dart';

class HomePage extends StatefulWidget{
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
                    return ProductItem();
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
      onTap: () =>  Navigator.push(context,MaterialPageRoute(builder:(c) => ProductDetailScreen(product: Product(),))),
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

  Widget discountListItem(){
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () =>  Navigator.push(context,MaterialPageRoute(builder:(c) => ProductDetailScreen(product: Product()))),
        child: Container(
      height: widgetHeight(200),
      width: 140,
      padding: EdgeInsets.only(left: 20,top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: AppThemes.mainColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.cover,),),
          SizedBox(height: 12,),
          Text.rich(TextSpan(
            children: <TextSpan>[
              new TextSpan(
                  text: '40%  ',
                  style: priceStyle.copyWith(color: AppThemes.pointColor,fontSize: 16)
              ),
              new TextSpan(
                text: '할인',
                style: priceStyle,
              ),

            ],
          )),
          SizedBox(height: 8,),
          Text("챔피온 티셔츠",style: AppThemes.textTheme.bodyText1),
          SizedBox(height: 6,),
          Text.rich(TextSpan(
            children: <TextSpan>[
              new TextSpan(
                text: '9000원   ',
                style: priceStyle
              ),
              new TextSpan(
            text: '15000원',
            style: priceStyle.copyWith(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),


        ],
      )),
          SizedBox(height: 6,),
        ],
      ),
    ));
  }


}