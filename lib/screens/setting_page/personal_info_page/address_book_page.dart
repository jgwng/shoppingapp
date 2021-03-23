import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page/modify_address_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class AddressBookPage extends StatefulWidget{
  @override
  _AddressBookPageState createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage>{
  List<SelectNumModel> selectAddress = List<SelectNumModel>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectAddress = List.generate(5,(i) => SelectNumModel(data: i,isSelected:(i == 0)?true:false));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar : TextTitleAppBar(title : "배송지 주소록 관리"),
      body: SingleChildScrollView(
        controller: scrollController,

        child: Column(
          children: [
            SizedBox(height: 40,child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline_rounded,color: Colors.grey[600],size: 20,),
                  Text(" 최대 5개까지 저장이 가능합니다.",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey[600]),)
                ],
              ),
            ),),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
             child: ListView.separated(
               controller: scrollController,
               separatorBuilder: (ctx,i) => SizedBox(height: 20,),
               itemBuilder: (ctx,i) => addressListItem(selectAddress[i]),
               shrinkWrap: true,
               itemCount: 5,
             ),
            ),
            SizedBox(height: 20,)
           ],
        )
      ),
      bottomNavigationBar: Container(
        height :60,

        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
        child: RaisedButton(
          elevation: 0,
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text("배송지 선택 완료",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
        ),
      ),

    );
  }

  Widget addressListItem(SelectNumModel selectNumModel){
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            setState(() {
              selectAddress.forEach((element) => element.isSelected = false);
              selectNumModel.isSelected = true;
            });
          },
          child: Container(
          height: 210,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: selectNumModel.isSelected ? AppThemes.pointColor : Colors.black)),

          padding: EdgeInsets.only(left: 24,right:15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              addressListText("아무개"),
              addressListText("46585"),
              addressListText("대전광역시 반석구 반석동로 33"),
              addressListText("507동 1702호"),
              SizedBox(height: 18,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  addressItemButton("수정",() => Navigator.push(context,MaterialPageRoute(builder:(c) => ModifyAddress()))),
                  SizedBox(width: 20,),
                  addressItemButton("삭제", () {print("삭제"); })
                ],)
            ],
          ),
        ),),
        Visibility(
          visible: selectNumModel.isSelected ? true : false,
          child: Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 50,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppThemes.mainColor,
                borderRadius: BorderRadius.circular(6.0),

              ),
              child: Text("기본",style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.white),textAlign: TextAlign.center,),
            ),
          ),
        )

      ],

    );
  }

  Widget addressListText(String text){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        Text(text,style: AppThemes.textTheme.bodyText1,),
      ],
    );
  }

  Widget addressItemButton(String text,VoidCallback voidCallback){
    return GestureDetector(
      onTap: voidCallback,
      child: Container(
        width: 80,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppThemes.mainColor,
          borderRadius: BorderRadius.circular(6.0),

        ),
        child: Text(text,style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.white),textAlign: TextAlign.center,),
      ),
    );
  }





}