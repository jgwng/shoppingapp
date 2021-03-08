import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';
class PointInfoPage extends StatefulWidget{
  @override
  _PointInfoPageState createState() => _PointInfoPageState();
}

class _PointInfoPageState extends State<PointInfoPage>{
  int selectUsageValue = 0;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title: "적립금",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
            Container(
              height: 80,
              alignment: Alignment.center,
              padding : EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("적립금",style : AppThemes.textTheme.headline2),
                  Text("15000원",style : AppThemes.textTheme.headline2.copyWith(color: AppThemes.pointColor)),
                ],
              ),
            ),
            SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
            Container(
              height: 80,
              padding: EdgeInsets.only(left: 24),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text("적립금 내역",style: AppThemes.textTheme.bodyText1,),
                  selectUsageTile(0, "전체"),
                  selectUsageTile(1, "사용"),
                  selectUsageTile(2, "적립"),
                ],
              ),
            ),
            Divider(height: 1,thickness: 1,color: Colors.grey[200],),
            pointUsageInfo("-879P"),
            Divider(height: 1,thickness: 1,color: Colors.grey[200],),




          ],
        ),
      ),
    );
  }
  
  Row selectUsageTile(int value, String usage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10,),
        SizedBox(
          width: 24,
          height: 24,
          child: CustomRadio(
              value: value,
              groupValue: selectUsageValue,
              onChanged: (newValue) {
                setState(() {
                  selectUsageValue = newValue;
                });
              },
              activeColor: AppThemes.mainColor,
              backgroundColor: Colors.white,
              inactiveColor:Colors.grey
          ),
        ),
        SizedBox(width: 5,),
        Text(
          usage,
          style:AppThemes.textTheme.subtitle2,
        )
      ],
    );
  }
  
  Widget pointUsageInfo(String usePoint){
    bool addOrUse = (usePoint.startsWith("+")) ? true : false;

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 40,
                padding: EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: addOrUse ? Colors.blue[800] : Colors.red[800],width: 2)
                ),
                child: Text(addOrUse ? "적립" : "사용" ,style: AppThemes.textTheme.bodyText1.copyWith(color: addOrUse ? Colors.blue[800] : Colors.red[800]),),
              ),
              SizedBox(width: 24,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2021.01.03",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),),
                  SizedBox(height: 5,),
                  Text("상품 결제",style: AppThemes.textTheme.bodyText1),
                  SizedBox(height: 8,),
                  Text("상품 주문 : 챔피온 티셔츠 외 1개",style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.black45))
                ],
              )
            ],
          ),
          Text("-879P",style: AppThemes.textTheme.headline1.copyWith(color: addOrUse ? Colors.blue[800] : Colors.red[800]))
        ],
      ),
    );
  }





}