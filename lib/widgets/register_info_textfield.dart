import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class RegisterInfoField extends StatefulWidget{
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String iconName;
  final Function(String number) function;
  final String hintText;
  RegisterInfoField({Key key,this.textEditingController,this.focusNode,this.iconName,this.function,this.hintText}) : super(key:key);




  @override
  _RegisterInfoFieldState createState() => _RegisterInfoFieldState();
}

class _RegisterInfoFieldState extends State<RegisterInfoField>{
  TextStyle textStyle = AppThemes.textTheme.headline1.copyWith(
      fontSize: 15, color: Colors.black);





  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[700],width: 1)
            ),

            //이름
            child: TextFormField(
                controller: widget.textEditingController,
                focusNode: widget.focusNode,
                validator: widget.function,
                style:TextStyle(color: Colors.black45),
                keyboardType: (widget.iconName == "핸드폰 번호((-) 없이)") ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_rounded),
                  suffixIcon: GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text("인증번호 전송",style: textStyle,),
                    ),
                  ),
                  hintText: widget.hintText,
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