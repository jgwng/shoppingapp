import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';

class OrderCartPage extends StatefulWidget{
  @override
  _OrderCartPageState createState() => _OrderCartPageState();
}

class _OrderCartPageState extends State<OrderCartPage>{
  bool isSelected = false;
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title:"장바구니"),
      body: SingleChildScrollView(
        child: Container(
         height: 300,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(width:20,child: CustomCheckBox(
                    radius: Radius.circular(3),
                    borderColor: Colors.black,
                    value: isSelected,
                    checkColor: Colors.white,
                    activeColor: AppThemes.mainColor,
                    onChanged: (value)  {
                      setState(() {
                       isSelected = !isSelected;
                      });
                    }, //체크시 개인정보 수집 및 이용 동의
                  ),),
                  SizedBox(width:10),
                  SizedBox(width: 80,height: 80,
                    child: Image.asset("assets/images/data_none_page/unicorn.png",fit: BoxFit.cover,),),
                  SizedBox(width:10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("상품명이 아주 긴 경우\n\n40000원",style: AppThemes.textTheme.headline1),

//                      Text("가격이 들어간다",style: AppThemes.textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400))
                    ],
                  ),
                  SizedBox(width:20),
                  Container(
                    padding: EdgeInsets.only(top:10),
                   child : Icon(Icons.clear)

                  )
                ],
              ),
              SizedBox(height: 20,),

              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("수량",style: AppThemes.textTheme.headline1),
                    Container(
                      height: 50,
                      width :180,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(12.0),
                        border: Border.all(color: AppThemes.mainColor)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(itemCount !=1){
                                  itemCount -=1;
                                }
                              });
                              },
                            child: Text("-",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 25, color: itemCount ==1 ? Colors.grey[400] : Colors.black),),),
                          Text("$itemCount",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 25),),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                itemCount +=1;
                              });
                            },
                            child: Text("+",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 25),),
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Text("옵션",style: AppThemes.textTheme.headline1),
                    Text("옵션 변경",style: AppThemes.textTheme.bodyText1)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                  color: AppThemes.mainColor,
                  child: Text("바로 주문"),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  
}