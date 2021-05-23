import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/order.dart';
import 'package:shoppingapp/screens/order_check_page/order_info_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:shoppingapp/screens/home_page/product_option_select_page.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/screens/no_data_page/no_data_page.dart';
class OrderCartPage extends StatefulWidget{
  @override
  _OrderCartPageState createState() => _OrderCartPageState();
}

class _OrderCartPageState extends State<OrderCartPage>{
  bool isSelected = false;
  bool allSelected = false;
  int selectItemCount = 0;
  String option = 'XL / 퍼플';
  int itemCount = 1;
  int shipFee = 0;
  int totalPrice = 0;
  ScrollController scrollController = ScrollController();
  List<String> optionList;
  List<Cart> cartList;
  List<bool> cartSelectList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> option = ["XL","퍼플"];
    cartList = List.generate(3,(index) => Cart(option: option));
    cartSelectList = List.generate(3,(index) => false);
    optionList = [];
    cartList.forEach((element) {

      String option = "";
      element.option.forEach((element) {
        option = option + element;
      });
      optionList.add(option);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title:"장바구니"),
      body: (cartList.length != 0) ?  ListView(
        controller: scrollController,
        children: [
          StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.white,
              padding : EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                   Container(
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
                                allSelected = value;
                                for(int i =0;i<cartSelectList.length;i++){
                                  cartSelectList[i] = (value) ? true : false;
                                }
                                selectItemCount = value ? 3 : 0;
                                changeTotalPrice();
                              });
                            },
                          ),),
                          SizedBox(width: 10,),
                          Container(
                              padding: EdgeInsets.only(top:2,bottom: 1),
                              child: Text("전체 선택($selectItemCount/${cartList.length})",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),)
                          )
                        ],
                      ),
                    ),
                  Container(
                      padding: EdgeInsets.only(top:2,bottom: 1),
                      child:GestureDetector(
                        onTap: (){
                          setState(() {
                            cartList = [];
                            cartSelectList = [];
                          });
                        },
                        child: Text("전체 삭제",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey) ,
                      ),)
                  )
                ],
              ),
            ),
            content: Container(
              color: Colors.white,
              child: cartListView(),
            ),
          )
        ],
      ) : DataNonePage(title: "장바구니가\n비어있습니다!",),
      bottomNavigationBar: (cartList.length != 0) ? Container(
        height :60,

        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
        child: RaisedButton(
          elevation: 0,
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage(productList: [OrderItem()],))),
          child: Text("${(totalPrice ==0) ? 0 : totalPrice+2000}원 주문하기",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
        ),
      ) : null
    );
  }
   Widget cartListView(){
    return Column(
      children: [
        SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
        //물품 관련 위젯
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (ctx,i) => cartItem(i),
          separatorBuilder: (ctx,i) => SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
          itemCount: cartList.length,
          controller: scrollController,
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
                  Text("$totalPrice원", style: AppThemes.textTheme.subtitle1)
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
                  Text("$shipFee원", style: AppThemes.textTheme.subtitle1)
                ],
              ),
            ),
            Padding(
              padding : EdgeInsets.symmetric(vertical: 10),
              child : Divider(height: 1,thickness: 1,color: AppThemes.mainColor,)
            ),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text("총 주문 금액",style: AppThemes.textTheme.subtitle1.copyWith(color: Colors.grey)),
                  Text("${(totalPrice ==0) ? 0 : totalPrice+2000}원", style: AppThemes.textTheme.subtitle1)
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
                  Text("${(((totalPrice ==0) ? 0 : totalPrice+2000)*0.01).toStringAsFixed(0)}원", style: AppThemes.textTheme.subtitle1)
                ],
              ),
            ),
          ],
        )
      ],
    );
   }

  Widget cartItem(int index){
    return  Container(
      height: 350,
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
                value: cartSelectList[index],
                checkColor: Colors.white,
                activeColor: AppThemes.mainColor,
                onChanged: (value)  {
                  setState(() {
                    cartSelectList[index] = !cartSelectList[index];
                    selectItemCount = (value) ? selectItemCount + 1 : selectItemCount - 1;
                    changeTotalPrice();
                  });
                }, //체크시 개인정보 수집 및 이용 동의
              ),),
              SizedBox(width:5),
              Container(width: 80,height: 90,padding: EdgeInsets.only(top:10),
                child: Image.asset("assets/images/data_none_page/unicorn.png",fit: BoxFit.cover,),),
              SizedBox(width:5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("${cartList[index].productName}\n${cartList[index].price}원",style: AppThemes.textTheme.headline1,overflow: TextOverflow.ellipsis,),
                ],
              ),
              SizedBox(width:30),
              Container(
                  padding: EdgeInsets.only(top:20),
                  child : GestureDetector(
                    onTap: (){
                      print("AAAAA");
                      setState(() {
                        cartList.removeAt(index);
                        cartSelectList.removeAt(index);
                        if(selectItemCount != 0 ) selectItemCount -= 1;
                        changeTotalPrice();
                      });
                    },
                    child: Icon(Icons.clear),
                  )

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
                  child:Text(optionList[index],style : AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey)),
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
                Expanded(child: GestureDetector(
                  onTap: () async{
                    String result =  await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.35,
                            child: ProductOptionSelectPage(isCart: true,),
                          );
                        });
                    if(result != null){
                      setState(() {
                        optionList[index] = result;
                      });
                    }

                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,

                    padding: EdgeInsets.only(left:24,right:24,top:3),
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(12.0),
                        border: Border.all(color: AppThemes.mainColor)
                    ),
                    child: Text("옵션 변경",style: AppThemes.textTheme.subtitle1),
                  ),
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
                            if(cartList[index].itemCount !=1){
                              cartList[index].itemCount -=1;

                            }
                          });
                        },
                        child: Text("-",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20, color: cartList[index].itemCount ==1 ? Colors.grey[400] : Colors.black),),),
                      Text("${cartList[index].itemCount}",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20),),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            cartList[index].itemCount +=1;

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
                Text("${cartList[index].itemCount*cartList[index].price}원", style: AppThemes.textTheme.bodyText1)
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
              onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage(productList: [
                OrderItem(productName: cartList[index].productName,quantity: cartList[index].itemCount.toString(),color: '퍼플',size: 'XL',
                    amount: (cartList[index].price * cartList[index].itemCount).toString())
              ],))),
              color: AppThemes.mainColor,
              child: Text("바로 주문",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
            ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  void changeTotalPrice(){
    setState(() {
      totalPrice = 0;
      for(int i =0;i<cartList.length;i++){
        if(cartSelectList[i]){
          totalPrice +=(cartList[i].price) * (cartList[i].itemCount);
          shipFee =2000;
        }

      }
      if(totalPrice == 0 ){
        totalPrice = 0;
        shipFee = 0;
      }
    });
  }



}