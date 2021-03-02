import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';

class OrderRefundPage extends StatefulWidget{
  @override
  _OrderRefundPageState createState() => _OrderRefundPageState();
}

class _OrderRefundPageState extends State<OrderRefundPage>{
  int refundValue = 0;
  TextEditingController accountOwnerController = TextEditingController();
  TextEditingController accountInfoController = TextEditingController();


  List<SelectStringModel> refundReasonModel = List<SelectStringModel>();
  List<String> refundReasonTextList = ["단순 반품","색상/사이즈 불만","사진과 다른 상품","상품 파손/불량","구성품의 누락","다른 상품 배송"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refundReasonModel = List.generate(refundReasonTextList.length,(i) => SelectStringModel(text: refundReasonTextList[i],isSelected:false));
  }







  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: TextTitleAppBar(title : "환불 신청"),
     body: NotificationListener<OverscrollIndicatorNotification>(
         onNotification: (OverscrollIndicatorNotification overScroll) {
           overScroll.disallowGlow();
           return false;
         },child: GestureDetector(
            onTap : () => unFocus(),
            child : SingleChildScrollView(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundFeeInfo(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundReasonInfo(),

                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundNoticeInfo()

                ],
              ),
            ))),
   );
  }



  Widget refundFeeInfo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text("환불 계좌 입력",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child:  Divider(height: 1,color: AppThemes.mainColor,thickness: 1,),
          ),
          Row(
            children: [
              SizedBox(
                width : 100,
                child :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:8),
                    Text("예금주명",style:AppThemes.textTheme.bodyText1)
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  controller: accountOwnerController,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.all(0),

                    suffix: GestureDetector(
                      onTap: () {
                        accountOwnerController.clear();
                      },
                      child : SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(Icons.clear,size: 18,)
                    )
                    )
                    )
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  //은행 선택하는 바텀 시트 뜨게 하기
                },
                child: SizedBox(
                  width : 100,
                  child :Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height:5),
                      Row(

                        children: [
                          Text("국민은행",style:AppThemes.textTheme.bodyText1),
                          Icon(Icons.arrow_drop_down),
                        ],
                      )
                    ],
                  ),
                )
              ),

              Expanded(
                child: TextField(
                  controller: accountInfoController,
                    keyboardType: TextInputType.number,
                    minLines: 1,
                    maxLines: 1,
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.all(0),

                        hintStyle: AppThemes.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1.0)
                        ),
                        hintText: "계좌번호((-) 없이)",





                    )
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget refundReasonInfo(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
         child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                SizedBox(height: 20,),
                Text("반품 사유",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child:  Divider(height: 1,color: AppThemes.mainColor,thickness: 1,),
                ),
               SizedBox(height: 10,),
               ScrollConfiguration(
                 behavior: MyBehavior(),
                 child: GridView.count(
                     physics: NeverScrollableScrollPhysics(),
                     padding: EdgeInsets.symmetric(vertical: 5),
                     crossAxisCount:2,
                     childAspectRatio: 140/50,
                     crossAxisSpacing: 30.0,
                     mainAxisSpacing: 30.0,
                     shrinkWrap: true,
                     children: List.generate(6, (index){
                       return refundReasonItem(refundReasonModel[index]);
                     })
                 ),
               ),
               SizedBox(height: 30),
      ],
         ));
  }

  Widget refundReasonItem(SelectStringModel selectStringModel){
    return GestureDetector(
      onTap: (){
        setState(() {
          refundReasonModel.forEach((element) => element.isSelected = false);
          selectStringModel.isSelected = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: selectStringModel.isSelected ? AppThemes.mainColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[700],width: 1)
        ),
        alignment: Alignment.center,
        child: Text(selectStringModel.text,style: AppThemes.textTheme.bodyText1.copyWith(
          color : selectStringModel.isSelected ? Colors.white : Colors.black
        ),),
      ),
    );
  }

  Widget refundNoticeInfo(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 20,),
          Text("교환 / 환불 안내",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
          Container(
          padding: EdgeInsets.symmetric(vertical: 8),
            child:  Divider(height: 1,color: AppThemes.mainColor,thickness: 1,),
        ),

            Text('단순변심으로 인한 교환/환불인 경우 반송비를 입금해주셔야\n합니다.'),
            Text('단순변심으로 인한 교환/환불인 경우 제품 및 포장 상태가\n재판매 가능하여야 합니다.'),






          ]));}





  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();

    }
  }
}