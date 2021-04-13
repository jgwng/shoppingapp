import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
class ImagePickerBottomSheet extends StatefulWidget {
  @override
  _ImagePickerBottomSheetState createState()=> _ImagePickerBottomSheetState();
}


class _ImagePickerBottomSheetState extends State<ImagePickerBottomSheet>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.87)))
      ),
      height:  170.0,
      child: Column(
        children: [
          buildHeader(context),
          buildBody(context),
        ],
      ),
    );
  }
  Widget buildBody(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color.fromRGBO(239, 240, 242, 1.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.image, size: 24,),
              onTap: ()async{
                Navigator.pop(context, false);
              },
              title: Text("갤러리에서 가져오기",style: AppThemes.textTheme.subtitle1.copyWith(color: const Color.fromRGBO(42, 42, 42, 1.0))),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, size: 24,),
              onTap: ()async {
                Navigator.pop(context, true);
              },
              title: Text("사진 촬영하기",style:  AppThemes.textTheme.subtitle1.copyWith(color: const Color.fromRGBO(42, 42, 42, 1.0))),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.16)))
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "사진 가져오기", style:  AppThemes.textTheme.subtitle1.copyWith(fontWeight: FontWeight.w400,color: const Color.fromRGBO(42, 42, 42, 1.0)),
            ),
          ),
          InkWell(child: Icon(Icons.close), onTap: (){
            Navigator.of(context).pop();
          },),
        ],
      ),
    );
  }
}
