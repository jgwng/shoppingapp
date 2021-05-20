import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/models/address.dart';
class ModifyAddress extends StatefulWidget{
  @override
  _ModifyAddressState createState() => _ModifyAddressState();
}

class _ModifyAddressState extends State<ModifyAddress>{
  String postNumber = '';
  String firstAddress = '검색을 통해 주소를 입력하세요';

  Address newAddress = Address();
  TextEditingController secondAddressController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  FocusNode secondAddressFocusNode = FocusNode();
  FocusNode recipientFocusNode = FocusNode();


  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title : "배송지 추가하기"),
      body : Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
         children: [
           SizedBox(height:20),
           inputAddress()
         ],
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
          onPressed: () {
            newAddress.address = [postNumber,firstAddress,secondAddressController.text];
            newAddress.isBasic = false;
            Navigator.pop(context,newAddress);
          },
          child: Text("배송지 수정하기",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
        ),
      ),
    );
  }
  Widget inputAddress(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height:40,
              alignment : Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey),
                  borderRadius: BorderRadius.circular(6.0)
              ),
              child: Text(postNumber,style : textStyle),
            ),
            SizedBox(width: 10,),
            RaisedButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus.unfocus();
                KopoModel model = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Kopo(),
                    ));

                if (model != null) {
                  setState(() {
                    postNumber = model.zonecode;
                    firstAddress = model.address;
                    FocusScope.of(context).requestFocus(secondAddressFocusNode);
                  });
                }
              },
              child: Text("주소 검색"),
            )
          ],
        ),
        SizedBox(height:20),
        Container(
          width: size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey,width: 1)
          ),
          alignment : Alignment.centerLeft,
          padding: EdgeInsets.only(left: 20),
          child: Text(firstAddress,style: textStyle,textAlign: TextAlign.left,),
        ),
        SizedBox(height:20),
        infoField(secondAddressController,secondAddressFocusNode,"나머지 주소",2),

      ],
    );
  }

  Widget infoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,int index){
    return Column(
      children: [
        Container(
            height: 50,
            padding: (index == 3) ? EdgeInsets.symmetric(horizontal: 8) : EdgeInsets.only(left:20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color:Colors.grey)
            ),
            //이름
            child: TextFormField(
                controller: textEditingController,
                focusNode: focusNode,

                style:TextStyle(color: Colors.black),
                keyboardType: (index == 3) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(

                  prefixIcon: (index == 3) ? Icon(Icons.supervisor_account) : null,
                  suffixIcon: ((index == 3)) ? GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text("번호 인증",style: textStyle,),
                    ),
                  ) : null,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent)),
                )
            )
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}