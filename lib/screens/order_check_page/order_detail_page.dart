import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/order_check_page/order_refund_page.dart';
import 'package:shoppingapp/screens/order_check_page/product_comment_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:flutter/services.dart';

class OrderDetailPage extends StatefulWidget{
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>{
  TextStyle textStyle = AppThemes.textTheme.bodyText1;
  TextStyle detailStyle = AppThemes.textTheme.bodyText1.copyWith(fontSize: 14);
  TextStyle paymentStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);

  double orderItemLength = 3.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: TextTitleAppBar(title: "주문 상세",),
        body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },child : SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderSummary(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderDetail(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              paymentList(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderInformation(),
              SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
              deleteOrRefund(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height :30),
                    RichText(
                      text: TextSpan(text: '24시간 연중무휴 고객 센터  ',style : textStyle.copyWith(
                          color: Colors.grey,fontSize: 14
                      ),children:[
                        TextSpan(text: '1234-5678',style : textStyle.copyWith(fontWeight: FontWeight.w700))
                      ]),
                    ),
                    SizedBox(height: 8,),
                    Text("CopyRight to Gunny in Daejeon, All Rights Reserved",style: AppThemes.textTheme.bodyText2.copyWith(
                        color: AppThemes.inActiveColor
                    ),textAlign: TextAlign.center),
                    SizedBox(height :30),

                  ],
                ),
              )

            ],
          ),
        )
        ));
  }

  Widget orderSummary(){
    return Container(
      padding: EdgeInsets.only(left: 24,top : 20,right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("현재 배달중입니다.",style:textStyle.copyWith(color: Colors.grey[700])),
          SizedBox(height : 10),
          Text("챔피온 후드티  외   1개",style: textStyle.copyWith(),),
          SizedBox(height: 20,),
          // 운송장번호 조회 런쳐 연결 고민중
          //https://tracking.sweettracker.co.kr/#ask - 한진 택배 추적 api 참고
          //https://shlee0882.tistory.com/59 - 위의 sweettracker 사용 방법
          RichText(
            text: TextSpan(text: '운송장 번호 :  ',style : textStyle.copyWith(
              color: Colors.grey,
            ),children:[
              TextSpan(text: '123456789112(한진택배)',
                  recognizer: TapGestureRecognizer()..onTap =(){
                    Clipboard.setData(new ClipboardData(text: "123456789112"));
                  },
                  style : textStyle.copyWith(fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,decorationColor: AppThemes.mainColor,color: AppThemes.mainColor))
            ]),
          ),
          SizedBox(height: 10,),
          Text("주문 일시 : ",style:textStyle.copyWith(color: Colors.grey)),
          SizedBox(height : 5),
          Text("주문 번호 : ",style:textStyle.copyWith(color: Colors.grey)),
          SizedBox(height: 20,),
        ],
      ),
    );
  }


  Widget orderDetail(){
    return Container(
      height: 110*orderItemLength,
      padding: EdgeInsets.only(left: 24,top: 30,right: 24),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderItemLength.toInt(),
        itemBuilder: (ctx, i) => orderDetailItem(),
        separatorBuilder:  (ctx, i) => Column(
          children: [
            SizedBox(height : 25),
            Divider(height: 1,thickness: 2,color: Colors.grey,),
            SizedBox(height : 25),
          ],
        ),
      ),
    );
  }

  Widget orderDetailItem(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("챔피온 후드티 1개",style:textStyle),
            Text('25000원',style:textStyle)
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
          children: [
            Text("상세  -  색상 : 퍼플  /  사이즈 : XL(105)",style: detailStyle.copyWith(color: Colors.grey),),

            Container(
              height: 30,
              child: RaisedButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(c) => ProductCommentPage())),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)
                ),
                child: Text("후기 작성",style: detailStyle,),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget paymentList(){
    return Container(
        padding: EdgeInsets.only(left: 24,top : 20,right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            paymentListItem("총 주문 금액","75000원"),
            SizedBox(height: 10,),
            paymentListItem("배송비","2000원"),
            SizedBox(height: 30,),
            Divider(height: 2,thickness: 1,color: Colors.grey,),
            SizedBox(height: 30,),
            paymentListItem("총 결제 금액","77000원"),
            SizedBox(height: 10,),
            paymentListItem("결제방법","계좌이체"),
            SizedBox(height: 20,),
          ],
        ));
  }
  Widget paymentListItem(String firstText, String secondText){
    return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(firstText,style: paymentStyle),
        Text(secondText,style: paymentStyle)
      ],);
  }

  Widget orderInformation(){
    return Container(
        padding: EdgeInsets.only(left: 24,top : 20,right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("배송지 정보",style: textStyle.copyWith(fontWeight: FontWeight.w700,fontSize: 18),),
            SizedBox(height: 30,),
            orderInfoItem("받는분"),
            orderInfoItem("연락처"),
            orderInfoItem("배송지"),
            SizedBox(height: 10,),
          ],
        ));
  }

  Widget orderInfoItem(String label){
    return Column(
      children: [
        Row(
          children: [
            Text(label,style: textStyle.copyWith(color: Colors.grey),),
            SizedBox(width : 40),
            Text("aaa",style : textStyle),
          ],
        ),SizedBox(height: 20,)
      ],
    );
  }

  Widget deleteOrRefund(){
    return Container(
        color: Colors.grey[200],
        child: Row(
          children: [
            delOrReButton("주문내역 삭제",onPressedForDelete),
            delOrReButton("환불 신청",onPressedForRefund),
            //주문 내역 삭제  & 환불 신청
          ],)

    );
  }

  Widget delOrReButton(String title,VoidCallback function){
    return Expanded(
      child: Container(
        padding :EdgeInsets.symmetric(horizontal: 24),
        height: 45,
        child: RaisedButton(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: Colors.black, width: 2,),
            ),
            onPressed: function,
            child :Text(title,style: textStyle.copyWith(fontSize: 15),)
        ),
      ),
    );
  }

  void onPressedForDelete(){
    Navigator.pop(context);
  }
  void onPressedForRefund(){

    Navigator.push(context,MaterialPageRoute(builder:(c) => OrderRefundPage()));
  }

}