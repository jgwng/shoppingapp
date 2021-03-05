import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class OrderCartPage extends StatefulWidget{
  @override
  _OrderCartPageState createState() => _OrderCartPageState();
}

class _OrderCartPageState extends State<OrderCartPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
         height: 300,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:30),
                  SizedBox(width: 80,height: 80,
                    child: Image.asset("assets/images/data_none_page/unicorn.png",fit: BoxFit.cover,),),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("상품명이 아주 긴 경우",style: AppThemes.textTheme.headline1),
                      SizedBox(height: 20,),
                      Text("무료 배송 / 일반 택배",style: AppThemes.textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  
}