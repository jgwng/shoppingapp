import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/check_coupon_info_dialog.dart';
import 'package:shoppingapp/widgets/animation_coupon.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class CouponListPage extends StatefulWidget{
  @override
  _CouponListPageState createState() => _CouponListPageState();
}

class _CouponListPageState extends State<CouponListPage>{
  TextStyle boldStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,fontSize: 14);
  List<String> couponNoticeList = ["최소 15,000원 이상 주문시 사용가능합니다.","다른 쿠폰과 중복 사용하실 수 없습니다.","쿠폰은 다른 계정으로 양도할 수 없습니다."];
  TextEditingController couponController = TextEditingController();
  bool isFocused = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title: "쿠폰함",),
      body: GestureDetector(
        onTap: () => unFocus(),
        child:SingleChildScrollView(

          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left:30),
                child: Text("쿠폰 등록",style: AppThemes.textTheme.subtitle1,),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(6.0)
                          ),
                          child:TextField(
                            style: AppThemes.textTheme.bodyText1,
                            controller: couponController,
                            decoration: InputDecoration(

                              contentPadding: EdgeInsets.only(top: 0),
                              hintText: "쿠폰번호를 입력하세요.",
                              hintStyle: AppThemes.textTheme.bodyText1.copyWith(color: Colors.grey),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                            ),
                          ),
                        )),
                    SizedBox(width: 20,),
                    Container(width: 80,height : 50,
                      child: RaisedButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return CheckCouponDialog();
                              }
                          );
                        },
                        color: AppThemes.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text("입력",textAlign: TextAlign.center,style: AppThemes.textTheme.bodyText1.copyWith(color: Colors.white),),
                      ),)
                  ],
                ),
              ),
              SizedBox(height:20),
              Divider(height: 1,thickness: 1,color: AppThemes.mainColor,),
              SizedBox(height: 20,),
              Row(children: [
                SizedBox(width: 20,),
              RichText(

                text: TextSpan(
                    children: [
                      TextSpan(text : "보유쿠폰 ",style:AppThemes.textTheme.bodyText1.copyWith(
                          color: AppThemes.inActiveColor
                      )),
                      TextSpan(text : "1",style: AppThemes.textTheme.subtitle1.copyWith(
                          color: AppThemes.pointColor
                      )),
                      TextSpan(text : "장",style: AppThemes.textTheme.bodyText1.copyWith(
                          color: AppThemes.inActiveColor
                      )),
                    ])),




              ],),

              SizedBox(height: 10,),
              Center(child:
              GunnyCoupon(
                width: double.infinity,
                height: 187.0,

                frontCoupon: frontCoupon(),
                backCoupon: backCoupon(),
              ),)
            ],
          ),
        ),
      ),
    );
  }


  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }




  Widget couponInfo(String title, String value){
    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
            children: [
              TextSpan(text : title,style: AppThemes.textTheme.bodyText2.copyWith(fontSize: 14)),
              TextSpan(text : value,style: boldStyle),
            ]));
  }

  Widget frontCoupon(){
    return Stack(
      children: [
        Container(

          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:Card(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right : 15),
              child: Column(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("5000원",style:  AppThemes.textTheme.subtitle1.copyWith(fontSize: 40),),
                      Text("유의사항 확인 > ",style: AppThemes.textTheme.bodyText2.copyWith(color : Colors.grey),),

                    ],
                  ),
                  SizedBox(height: 50,),
                  //쿠폰 제목
                  Text("2월 월간 쿠폰",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 22)),
                  //쿠폰 유효 기간
                  couponInfo("유효기간 : ", "2021년 02월 18일"),
                  couponInfo("최소 주문 금액 : ", "15000원"),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 40,
          bottom: 15,
          child: Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/images/coupon_list_page/checkmark.png'),
          ),
        ),

      ],
    );
  }









  Widget backCoupon(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child:Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 15),
          child: Column(

            children: [
              SizedBox(height: 5,),
              Text("쿠폰 유의사항",style: AppThemes.textTheme.bodyText1,),
              SizedBox(height: 10,),
              Divider(height: 1, color: AppThemes.mainColor,thickness: 2,),
              SizedBox(height: 10,),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  itemCount: couponNoticeList.length,
                  itemBuilder: (ctx,i) => backCouponNoticeItem(i),
                  separatorBuilder: (ctx,i) => SizedBox(height: 5,),) ,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget backCouponNoticeItem(int index){
    return Row(
      children: [
        Icon(Icons.fiber_manual_record,size: 8,),
        SizedBox(width: 5,),
        Text(couponNoticeList[index],style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 14),)
      ],
    );
  }






}