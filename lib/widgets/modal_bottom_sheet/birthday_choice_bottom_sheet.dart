import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/custom_text_button.dart';
import 'package:intl/intl.dart';
class BirthdayChoiceBottomSheet extends StatefulWidget {

  @override
  _BirthdayChoiceBottomSheetState createState()=> _BirthdayChoiceBottomSheetState();
}

class _BirthdayChoiceBottomSheetState extends State<BirthdayChoiceBottomSheet>{
  DateTime dateTime;
  final initDate = DateFormat('yyyy-MM-dd').parse('2000-01-01');


  TextStyle textStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w500,fontSize: 15,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));


  @override
  void initState() {
    super.initState();
    dateTime =DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: "생년월일",
                  style: textStyle),
              TextSpan(
                  text: "을 입력해주세요", style: textStyle),
            ]),
            textAlign: TextAlign.center,
          ),
          _buildButtons(context),
          Container(
            height: 250,
            child: CupertinoDatePicker(
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
              initialDateTime: DateTime.now(),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (value) {
                setState(() {
                  dateTime = value;
                  print(value);
                });
              },
              mode: CupertinoDatePickerMode.date,

            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 40, right: 40),
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
                Navigator.pop(context, dateTime);
              },
              foregroundColor: Color.fromRGBO(75, 75, 75, 1.0)),
        ],
      ),
    );
  }
}