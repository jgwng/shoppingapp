import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';

class OrderRefundPage extends StatefulWidget{
  @override
  _OrderRefundPageState createState() => _OrderRefundPageState();
}

class _OrderRefundPageState extends State<OrderRefundPage>{
  int refundValue = 0;
  TextEditingController accountOwnerController = TextEditingController();
  TextEditingController accountInfoController = TextEditingController();

  TextStyle textStyle = AppThemes.textTheme.subtitle2;
  TextStyle detailStyle = AppThemes.textTheme.bodyText1.copyWith(fontSize: 14);
  TextStyle paymentStyle = AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700);

  double orderItemLength = 3.0;
  List<SelectStringModel> refundReasonModel = List<SelectStringModel>();
  List<String> refundReasonTextList = ["단순 반품","색상/사이즈 불만","사진과 다른 상품","상품 파손/불량","구성품의 누락","다른 상품 배송"];
  List<bool> selectedItem = [false,false,false];
  int selectedItemFee = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refundReasonModel = List.generate(refundReasonTextList.length,(i) => SelectStringModel(text: refundReasonTextList[i],isSelected:false));
  }







  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
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
                  refundReturnFeeInfo(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundReasonInfo(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  selectRefundItem(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundFeeInfo(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                  refundNoticeInfo(),
                  SizedBox(height: 30,child: Container(color: Colors.grey[200],),),
                   refundButton('환불 신청',(){}),
                ],
              ),
            ))),
   );
  }

  Widget refundButton(String title,VoidCallback function){
    return Container(
        padding :EdgeInsets.only(left: 24,right: 24,bottom: 20),
        width: size.width,
        height: 80,
        color: Colors.grey[200],
        child: RaisedButton(
            elevation: 0,
            color: AppThemes.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(color: AppThemes.mainColor, width: 2,),
            ),
            onPressed: function,
            child :Text(title,style: textStyle.copyWith(fontSize: 20,color: Colors.white),)
        ),
      );
  }

  Widget refundReturnFeeInfo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("환불 계좌 입력",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
              Text('기본 환불 계좌 사용',style:AppThemes.textTheme.subtitle2)
              ],
          ),
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

  Widget selectRefundItem(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20,),
      Text("반품 물건 선택",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child:  Divider(height: 1,color: AppThemes.mainColor,thickness: 1,),
      ),
      SizedBox(height: 3,),
      refundItemDetail()
    ]));
  }

  Widget refundFeeInfo(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("환불 예상 금액",textAlign: TextAlign.left,style:AppThemes.textTheme.bodyText1),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child:  Divider(height: 1,color: AppThemes.mainColor,thickness: 1,),
              ),
              SizedBox(height: 10,),
              paymentListItem("총 환불 금액","${selectedItemFee.toString()}원"),
              SizedBox(height: 10,),
              paymentListItem("반송비","2000원"),
              SizedBox(height: 20,),
              Divider(height: 2,thickness: 1,color: Colors.grey,),
              SizedBox(height: 20,),
              paymentListItem("예상 반환 금액","${(selectedItemFee == 0) ? 0 : (selectedItemFee-2000).toString()}원"),
              SizedBox(height: 20,),
            ]));
  }

  Widget paymentListItem(String firstText, String secondText){
    return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(firstText,style: paymentStyle),
        Text(secondText,style: paymentStyle)
      ],);
  }
  Widget refundItemDetail(){
    return Container(
      height: 75*orderItemLength,

      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderItemLength.toInt(),
        itemBuilder: (ctx, i) => refundItem(i),
        separatorBuilder:  (ctx, i) => Column(
          children: [
            SizedBox(height : 15),
            Divider(height: 1,thickness: 2,color: Colors.grey,),
            SizedBox(height : 15),
          ],
        ),
      ),
    );
  }

  Widget refundItem(int i){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 24,
          height: 24,
          padding: EdgeInsets.only(top:5,left: 10),
          child: CustomCheckBox(
            radius: Radius.circular(3),
            borderColor: Colors.black,
            value: selectedItem[i],
            checkColor: Colors.white,
            activeColor: AppThemes.mainColor,
            onChanged: (value)  {
              setState(() {
                selectedItemFee = (value) ? selectedItemFee + 25000 : selectedItemFee - 25000;
                selectedItem[i] = value;
              });
            }, //체크시 개인정보 수집 및 이용 동의
          ),
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text("챔피온 후드티 1개",style:textStyle),
            SizedBox(height: 5,),
            Text("상세 - 색상 : 퍼플/사이즈 : XL(105)",style: detailStyle.copyWith(color: Colors.grey),)
          ],
        ),

        Column(
          mainAxisAlignment : MainAxisAlignment.spaceBetween,
          children: [
            Text('25000원',style:textStyle),
          ],
        )
      ],
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


//            noticeItem('반송하신 제품 및 포장 상태가 재판매 가능한 \n','상태여야 합니다.\n'),
            SizedBox(height: 5,),
            noticeItem('반송하신 제품 및 포장 상태가 재판매 가능한','     상태여야 합니다.\n'),
            noticeItem('상품 불량이 확인된 제품의 경우에는 배송비를 포함한','     전액이 환불됩니다\n'),
            noticeItem('출고 이후 환불요청시 상품 회수 후 처리됩니다.','     '),
            SizedBox(height: 5,),






          ]));}


   Widget noticeItem(String text,String nextText){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 3.0,
              backgroundColor: Colors.black,
            ),
            SizedBox(width: 10,),
            Text(text,style:textStyle)
          ],
        ),
        Text(nextText,style:textStyle)
      ],
    );
   }



  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();

    }
  }
}