import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/order_check_page/order_info_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';
import 'package:sticky_headers/sticky_headers.dart';

class OrderCartPage extends StatefulWidget{
  @override
  _OrderCartPageState createState() => _OrderCartPageState();
}

class _OrderCartPageState extends State<OrderCartPage>{
  bool isSelected = false;
  bool allSelected = false;

  int itemCount = 1;
  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title:"장바구니"),
      body: SingleChildScrollView(

        child: StickyHeader(
          header: Container(
            height: 40.0,
            color: Colors.white,
            padding : EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior:  HitTestBehavior.opaque,
                  onTap: (){
                    print("AAAA");
                  },
                  child:Container(
                    height: 40.0,
                    child: Row(
                      children: [
                        SizedBox(width:20,child: CustomCheckBox(
                          radius: Radius.circular(3),
                          borderColor: Colors.black,
                          value: allSelected,
                          checkColor: Colors.white,
                          activeColor: AppThemes.mainColor,
                          onChanged: (value)  {
                            setState(() {
                              allSelected = !allSelected;
                            });
                          }, //체크시 개인정보 수집 및 이용 동의
                        ),),
                        SizedBox(width: 10,),
                        Container(
                            padding: EdgeInsets.only(top:2,bottom: 1),
                            child: Text("전체 선택(0/1)",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),)
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top:2,bottom: 1),
                    child: Text("전체 삭제",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),)
                )
               ],
            ),
          ),
          content: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
                //물품 관련 위젯
                Container(
                  height: 340,
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
                      Row(
                        children: [
                          SizedBox(width: 30,),
                          Expanded(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6.0)
                              ),
                              child:Text('XL / 퍼플',style : AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),

                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 30,),
                            Expanded(child: Container(
                              height: 40,
                              alignment: Alignment.center,

                              padding: EdgeInsets.only(left:24,right:24,top:3),
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(12.0),
                                  border: Border.all(color: AppThemes.mainColor)
                              ),
                              child: Text("옵션 변경",style: AppThemes.textTheme.subtitle1),
                            ),),
                            SizedBox(width: 30,),
                            Expanded(child:Container(
                              height: 40,

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
                                    child: Text("-",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20, color: itemCount ==1 ? Colors.grey[400] : Colors.black),),),
                                  Text("$itemCount",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20),),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        itemCount +=1;
                                      });
                                    },
                                    child: Text("+",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20),),
                                  ),


                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(height :1,color:Colors.grey),
                      SizedBox(height: 5,),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text("결제 금액",style: AppThemes.textTheme.subtitle1),
                            Text("${itemCount*45000}원", style: AppThemes.textTheme.bodyText1)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color:AppThemes.mainColor,
                            borderRadius: BorderRadius.circular(6.0)
                        ),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage())),
                          color: AppThemes.mainColor,
                          child: Text("바로 주문",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
                // 금액 관련 위젯
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("총 상품 금액",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.grey)),
                          Text("${itemCount*45000}원", style: AppThemes.textTheme.subtitle1)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("배송비",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.grey)),
                          Text("2000원", style: AppThemes.textTheme.subtitle1)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(height:1,thickness: 1,color: AppThemes.mainColor,),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("총 주문 금액",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.grey)),
                          Text("${itemCount*45000+2000}원", style: AppThemes.textTheme.subtitle1)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("예상 적립금",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.grey)),
                          Text("${((itemCount*45000+2000)*0.01).toStringAsFixed(0)}원", style: AppThemes.textTheme.subtitle1)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height :60,

        padding: EdgeInsets.only(left: 24,right: 24,bottom:10,top:10),
        child: RaisedButton(
          elevation: 0,
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage())),
          child: Text("${itemCount*45000+2000}원 주문하기",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
        ),
      ),
    );
  }
  
}