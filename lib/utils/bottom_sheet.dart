import 'package:flutter/material.dart';

import 'package:shoppingapp/widgets/modal_bottom_sheet/birthday_choice_bottom_sheet.dart';


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