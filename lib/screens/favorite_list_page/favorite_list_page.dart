import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/models/select_model.dart';

class FavoriteListPage extends StatefulWidget{
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage>{
  List<String> categoryList =AppText.categoryList;

  List<SelectStringModel> categoryModel = List<SelectStringModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList.insert(0, "전체");
    categoryModel = List.generate(categoryList.length,(i) => SelectStringModel(text: categoryList[i],isSelected:(i == 0)?true:false));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(title : "찜"),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
  Widget categoryListItem(SelectStringModel selectModel){
    return GestureDetector(
      onTap: (){
        setState(() {
          categoryModel.forEach((element) => element.isSelected = false);
          selectModel.isSelected = true;
        });
      },child:Container(
      width: 90,
      height: 10,
      child: Card(

        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: selectModel.isSelected ? AppThemes.mainColor : Colors.white70, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child:Center(
              child : Text(
                selectModel.text,textAlign: TextAlign.center,
                style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 16),
              ),
            )
        ),
      ),
    ),
    );
  }
}