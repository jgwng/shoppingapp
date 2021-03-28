import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/screens/home_page/product_detail_page.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class ProductItem extends StatefulWidget{
//  ProductItem({Key key, this.product}) : super(key: key);
//  final Product product;
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>{
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(c) => ProductDetailScreen()));
      },child: Container(
      height: widgetHeight(200),
      width: 160,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6.0)
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text("제품명",overflow: TextOverflow.ellipsis,style: AppThemes.textTheme.bodyText1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("할인율",style: AppThemes.textTheme.bodyText2,),
              SizedBox(width: 20,),
              Text("가격",style: AppThemes.textTheme.subtitle2,)
            ],
          )
        ],
      ),
    ),
    );
  }

}