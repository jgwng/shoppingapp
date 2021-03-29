import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/custom_text_button.dart';
class InquiryCategoryChoiceBottomSheet extends StatefulWidget {

  @override
  _InquiryCategoryChoiceBottomSheetState createState()=> _InquiryCategoryChoiceBottomSheetState();
}

class _InquiryCategoryChoiceBottomSheetState extends State<InquiryCategoryChoiceBottomSheet>{
  List<Widget> inquiryCategoryList = [];

  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  String selectCategory = "";
  @override
  void initState() {
    super.initState();
    inquiryCategoryList = List.generate(AppText.inquiryCategory.length,(i) => Center(
        child: Text(
            AppText.inquiryCategory[i],
            textAlign: TextAlign.center,
            style: AppThemes.textTheme.headline1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      child: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 22,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: "문의 내용의 카테고리",
                  style: textStyle.copyWith(color: AppThemes.pointColor)),
              TextSpan(
                  text: "를 선택해주세요", style: textStyle),
            ]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:5),
          _buildButtons(context),
          Container(
            height: 260,
            child: CupertinoPicker(
              magnification: 1,
              backgroundColor: Colors.white,
              children: inquiryCategoryList,
              itemExtent: 50, //height of each item
              looping: true,
              onSelectedItemChanged: (int index) {
                selectCategory = AppText.inquiryCategory[index];
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            text: "취소",
            textStyle: textStyle,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            foregroundColor: Color.fromRGBO(75, 75, 75, 1.0),
          ),
          CustomTextButton(
              text: "입력",
              textStyle: textStyle,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context, selectCategory);
              },
              foregroundColor: Color.fromRGBO(75, 75, 75, 1.0)),
        ],
      ),
    );
  }
}