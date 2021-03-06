import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/account_bank_choice_bottom_sheet.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/image_picker_bottom_sheet.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/birthday_choice_bottom_sheet.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/sort_standard_bottom_sheet.dart';
import 'package:shoppingapp/widgets/modal_bottom_sheet/inquiry_category_choice_bottom_sheet.dart';

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

Future<String> onAccountBankPickerBottomSheet(BuildContext context) async{
  String result = await showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return AccountBankChoiceBottomSheet();
    },
  );
  print("result : $result");
  return result;
}

Future<String> onInquiryCategoryPickerBottomSheet(BuildContext context) async{
  String result = await showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return InquiryCategoryChoiceBottomSheet();
    },
  );
  print("result : $result");
  return result;
}

Future<bool> onImagePickerBottomSheet(BuildContext context)async {
  bool result = await showModalBottomSheet<bool>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return ImagePickerBottomSheet();
    },
  );
  return result;
}
