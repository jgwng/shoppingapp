import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/text_label_field.dart';

class RefundAccountPage extends StatefulWidget{
  @override
  _RefundAccountPageState createState() => _RefundAccountPageState();
}

class _RefundAccountPageState extends State<RefundAccountPage>{
  List<Widget> accountBankList = [];

  int selectItem = 0;

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountOwnerController = TextEditingController();

  String accountBank = "은행 선택";
  FocusNode accountNumberNode = FocusNode();
  FocusNode accountOwnerNode = FocusNode();

  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  @override
  void initState() {
    accountBankList = List.generate(AppText.bankList.length,(i) => Center(
      child: Text(
      AppText.bankList[i],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white, fontSize: 20,),
    )),
    );
    // TODO: implement initState
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title : "기본 환불 계좌 설정"),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          print("Tapped");
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(

          children: [
            SizedBox(height:30),
            accountBankField(),
            SizedBox(height:40),
            TextLabelField(controller: accountNumberController,focusNode: accountNumberNode,label: "예금주",hintText: "",isNumber: false,),
            SizedBox(height: 40,),
            TextLabelField(controller: accountOwnerController,focusNode: accountOwnerNode,label: "계좌번호",hintText: "",isNumber: true,),
            Spacer()
          ],
        ),
      ),
      ),
      bottomNavigationBar: Container(
        height :70,
        padding: EdgeInsets.only(left: 24,right:24,bottom: 20),
        child: RaisedButton(
          elevation: 0,
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text("배송지 수정하기",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
        ),
      ),

    );
  }

  Widget accountBankField(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child:  Text("은행",style: textStyle,)),
          SizedBox(width: 20,),
          Expanded(

              child: GestureDetector(
                onTap: () async {
                  String result = await onAccountBankPickerBottomSheet(context);
                  if(result != null){
                    setState(() {
                      accountBank =result;
                    });
                  }
                },
                child: Container(
                  height: 50,

                  padding: EdgeInsets.only(left: 15,right: 5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(accountBank,textAlign: TextAlign.center,style: (accountBank != "은행 선택") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
                      textStyle.copyWith(color:Colors.grey)),
                      Icon(Icons.arrow_drop_down_outlined,size: 30,)
                    ],
                  ),
                ),
              )
          ),
        ]
    );
  }

}