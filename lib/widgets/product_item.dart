import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/product.dart';

class ProductItem extends StatefulWidget{
  ProductItem({Key key, this.onPush}) : super(key: key);
  final Function onPush;
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem>{
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPush(Product())
      ,child: Container(
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