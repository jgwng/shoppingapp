import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/home_page/product_detail_page.dart';

class FavoriteListPage extends StatefulWidget{
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage>{
  List<String> categoryList =AppText.categoryList;
  List<SelectStringModel> categoryModel = List<SelectStringModel>();
  List<String> aaaList = ["","","","","","",""];
  bool isEditMode = false;
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
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title : "찜"),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height:10),
              Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.separated(
                      itemCount: categoryModel.length,
                      itemBuilder: (ctx,i) => categoryListItem(categoryModel[i]),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (ctx,i) =>SizedBox(width: 20,),
                    ),
                  )
              ),
              SizedBox(height:10),
              Divider(height: 1,thickness: 1,color: AppThemes.mainColor,),
              SizedBox(height:10),
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    crossAxisCount:2,
                    childAspectRatio: 80/80,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 30.0,
                    shrinkWrap: true,
                    children: List.generate(aaaList.length, (index){
                      return favoriteListItem();
                    })
                ),
              )
            ],
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

  Widget favoriteListItem(){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>  Navigator.push(context,MaterialPageRoute(builder:(c) => ProductDetailScreen())),
      onLongPress: (){
        setState(() {
          isEditMode = true;
        });
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [

          Container(
            height: 160,
            width: 160,
            alignment: Alignment.center,

            child: SizedBox(
              width: 155,
              height: 155,
              child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.fitWidth),
            ),
          ),
          Positioned(
            top: -10,
            right: 20,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  aaaList.remove(aaaList.last);
                });
              },
              child: Visibility(
                  visible: (isEditMode) ? true : false,
                  child: Icon(Icons.remove_circle_outline_rounded,size: 35,color: AppThemes.pointColor,)
              ),

            ),
          )
        ],
      ),
    );
  }
}