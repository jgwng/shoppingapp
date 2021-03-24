import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/widgets/product_image_indicator.dart';

class ProductDetailScreen extends StatefulWidget{
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin{
  int widgetIndex = 0;
  bool isFavorite = false;
  final PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title : "제품 상세"),
        body: ListView(
          children: [
            productInfo(),
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
        ),
        bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 15),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.grey)
                ),
                child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,size: 30,color: AppThemes.pointColor,),
              ),
            ),
            SizedBox(width: 30,),
            Expanded(
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: (){

                  },
                  color: AppThemes.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  child: Text("구매하기",style:AppThemes.textTheme.headline1.copyWith(color:Colors.white)),
                ),
              ),
            )

          ],
        ),  
    ),
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

  void _pageChanged(int index) {
    setState(() {});
  }
    Widget productInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },child :
          Column(
            children: [
            Container(
                  height: 350,
                  width: 350,
                  alignment: Alignment.center,

                  child:PageView.builder(
                    onPageChanged: _pageChanged,
                    controller: controller,

                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.fitWidth),
                      );
                    },
                    itemCount: 5,
                  ),
                ),
                Indicator(
                controller: controller,
                itemCount: 5,
                )
                ],
      )
        ),

        SizedBox(height: 30,),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("제품 이름이 들어갈 공간입니다.",style: AppThemes.textTheme.headline2,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10),
                Text("가격",style: AppThemes.textTheme.headline2,),
              ],
            )
        ),
        SizedBox(height: 20),
        Divider(height: 2,thickness: 1,color: AppThemes.mainColor,),
        SizedBox(height: 25,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productPriceInfo("적립금","100원"),
              SizedBox(height: 10,),
              productPriceInfo("배송비","2000원"),
              SizedBox(height: 10,),
              productPriceInfo("예상 도착일",conversionDateTime(DateTime.now())),
              SizedBox(height: 10,),
            ],
          ),
        )

      ],
    );
    }

  String conversionDateTime(DateTime dateTime){
    DateTime arriveDate = DateTime(dateTime.year,dateTime.month,dateTime.day+2);
    String newFormat = DateFormat("MM월 dd일").format(arriveDate);

    return newFormat;
  }



    Widget productPriceInfo(String label,String content){
    return Row(children: [
      SizedBox(
        width: 80,
        child: Text(label,style: AppThemes.textTheme.bodyText1.copyWith(color:Colors.grey)),
      ),
      SizedBox(width: 20,),
      Text(content,style: AppThemes.textTheme.bodyText1)
    ],);
    }





  }
//https://flutter-examples.com/set-text-overflow-ellipsis-text-in-flutter/