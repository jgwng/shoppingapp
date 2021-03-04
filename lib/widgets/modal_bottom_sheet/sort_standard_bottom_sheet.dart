import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';

class SortStandardBottomSheet extends StatefulWidget{
  SortStandardBottomSheet({Key key, this.index,}) : super(key: key);

  final int index;

  @override
  _SortStandardBottomSheetState createState() => _SortStandardBottomSheetState();
}

class _SortStandardBottomSheetState extends State<SortStandardBottomSheet>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      decoration: BoxDecoration(
          color: Colors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return ListView.separated(
      itemCount: 6,
      itemBuilder: (ctx,i) => standardItem(i,context),
        separatorBuilder: (ctx,i) => Divider(height :1,color: AppThemes.mainColor,thickness: 1,),
       );
  }

  Widget standardItem(int index,BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context,index);
      },
      child: Container(
        height:60,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            contentPadding: EdgeInsets.only(left:0),
            title: Text(AppText.standardList[index],style: AppThemes.textTheme.bodyText1.copyWith(
              fontWeight: (index == widget.index) ? FontWeight.w700 : FontWeight.w500
            ),),
            trailing: Visibility(
              visible: (index == widget.index) ? true : false,
              child: Icon(Icons.check,size:30,color:AppThemes.mainColor),
            ),
          ),
      ),
    );
  }





}