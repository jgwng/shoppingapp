import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/add_coupon_bottom_sheet.dart';

import 'package:shoppingapp/widgets/modal_bottom_sheet/birthday_choice_bottom_sheet.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/sort_standard_bottom_sheet.dart';


Future<DateTime> onBirthdayPickerBottomSheet(BuildContext context)async {
  DateTime result = await showModalBottomSheet<DateTime>(
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return BirthdayChoiceBottomSheet();
    },
  );
  print("result : $result");
  return result;
}

Future<int> onSortStandardPickerBottomSheet(BuildContext context, int index) async{
  int result = await showModalBottomSheet<int>(
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return SortStandardBottomSheet(index : index);
    },
  );
  print("result : $result");
  return result;
}


Future<String> addNewCouponBottomSheet(BuildContext context) async{
  String result = await showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return AddCouponBottomSheet();
    },
  );
  print("result : $result");
  return result;
}