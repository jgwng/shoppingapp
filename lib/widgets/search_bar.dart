import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class SearchBar extends StatelessWidget{
  final controller;
  final onChange;
  final VoidCallback onTap;
  final VoidCallback suffixIconOnTab;
  final FocusNode focusNode;
  final String hintText;
  SearchBar({Key key,this.onChange,this.controller,this.focusNode,this.onTap, this.suffixIconOnTab,this.hintText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
          height: 36,
          // padding: EdgeInsets.all(24),
          child : TextField(
            onTap: onTap,
            textAlignVertical: TextAlignVertical.bottom,
            style: AppThemes.textTheme.subtitle1,
            textInputAction: TextInputAction.done,
            focusNode: focusNode,
            decoration: InputDecoration(
                hintStyle: AppThemes.textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1.0)
                ),
                hintText: hintText,
                prefixIcon: Icon(Icons.search),
                suffixIcon: GestureDetector(
                    onTap: suffixIconOnTab,
                    child: Icon(Icons.clear_rounded)
                ),
                filled: true,
                fillColor: Color.fromRGBO(142, 142, 147, 0.24),
                border: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))

            ),
            controller: controller,
            onChanged: onChange,
          )
      ),
    );
  }
}


