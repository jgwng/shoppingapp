import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class TextLabelField extends StatelessWidget{
  TextLabelField({this.controller, this.label, this.color : const Color.fromRGBO(102, 102, 102, 1.0), this.hintText,
    this.onChanged,
    this.validatorFunction,this.focusNode,this.maxLength,this.initialValue,this.isNumber});
  final TextEditingController controller;
  final String label;
  final Color color;
  final String hintText;
  final onChanged;
  final Function(String number) validatorFunction;
  final bool isNumber;
  final FocusNode focusNode;
  final int maxLength;
  final String initialValue;


  final TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label,style: textStyle),
        ),
        SizedBox(width: 20,),
        Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color:Colors.grey)
            ),
            child : TextFormField(
                controller: controller,
                focusNode: focusNode,
                validator: validatorFunction,
                style:TextStyle(color: Colors.black),
                keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 2,
                    minHeight: 2,
                  ),
                  contentPadding: EdgeInsets.only(left:20,bottom:3),
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
        ),),

      ],
    );
  }

}