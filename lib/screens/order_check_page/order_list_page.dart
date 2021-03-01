import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/order_check_page/order_detail_page.dart';

class OrderList extends StatefulWidget{
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          SizedBox(height: 10,child: Container(color: Colors.grey[200],),),
          orderCard(),
          SizedBox(height: 10,child: Container(color: Colors.grey[200],),)
        ],
      )
    );
  }




  //주문 정보 알려주는 카드 아이템 하나
  Widget orderCard(){
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder:(c) => OrderDetailPage()));
      },
      child: Container(
          width: double.infinity,
          height: 160,
          padding: EdgeInsets.only(left: 20,right: 20,top: 15),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppThemes.inActiveColor,width:1),
                bottom: BorderSide(color: AppThemes.inActiveColor,width:1),
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("주문 번호 입니다.",style: AppThemes.textTheme.bodyText1,),
                  Row(
                    children: [
                      Text("상세보기",style: AppThemes.textTheme.bodyText2.copyWith(color: AppThemes.inActiveColor),),
                      Icon(Icons.arrow_forward_ios,color: AppThemes.inActiveColor,)

                    ],
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Divider(color: AppThemes.mainColor,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      cardItem("주문일시","2021/02/17 10:12"),
                      SizedBox(height: 5,),
                      cardItem("수량","3"),
                      SizedBox(height: 5,),
                      cardItem("결제가격","35,820"),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height:40),
                      Container(
                        width: 65,
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color : AppThemes.mainColor,
                            borderRadius: BorderRadius.circular(6.0)
                        ),
                        child: Text("배송 완료",style: TextStyle(color: Colors.white),),
                      )
                    ],
                  )
                ],
              ),
            ],
          )
      ),
    );
  }

  Widget cardItem(String title, String content){
    return Row(
      children: [
        SizedBox(width: 70,
          child: Text(title,style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 14),),),
        Text(content,style: AppThemes.textTheme.bodyText2,)
      ],
    );
  }
}