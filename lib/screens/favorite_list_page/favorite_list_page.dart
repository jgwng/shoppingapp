import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/app_text_list.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/widgets/app_bar/main_page_appbar.dart';

class FavoriteListPage extends StatefulWidget{
  FavoriteListPage({this.onPush});
  final Function onPush;
  @override
  _FavoriteListPageState createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage>{
  List<String> categoryList =['전체' ,...AppText.categoryList];
  List<SelectStringModel> categoryModel = List<SelectStringModel>();
  List<String> aaaList = ["","","","","","",""];
  bool isEditMode = false;
  List<Product> favoriteItemList;
  List<Product> displayList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryModel = List.generate(categoryList.length,(i) => SelectStringModel(text: categoryList[i],isSelected:(i == 0)?true:false));
    favoriteItemList = List.generate(10,(i)=> Product(
      category: categoryList[(i%6 ==0) ? 1 : i%6]
    ));
    displayList = favoriteItemList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(title:'찜',),
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
                    children: List.generate(displayList.length, (index){
                      return favoriteListItem(index);
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

          displayList = [];
          if(selectModel.text == '전체'){
            displayList = favoriteItemList;
          }else {
            favoriteItemList.forEach((element) {
              if(element.category == selectModel.text)
                displayList.add(element);
              print(element.category);
            });
          }
          print(displayList.length);

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

  Widget favoriteListItem(int index){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>  widget.onPush(Product()),
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
              child: productImage(displayList[index].category),
            ),
          ),
          Positioned(
            top: -10,
            right: 20,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  Product product = displayList[index];
                  displayList.remove(product);
                  favoriteItemList.remove(product);
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

  void sortFavorite(String category){
    setState(() {
      displayList = [];
      if(category == '전체'){
        displayList = favoriteItemList;
      }else {
        favoriteItemList.forEach((element) {
           if(element.category == category)
            displayList.add(element);
        });
      }
    });
  }


  Widget productImage(String category){
    String imageAddress;
    switch(category){
      case '유니섹스':
        imageAddress = 'hoodie';
        break;
      case "가방 잡화":
        imageAddress = 'dress';
        break;
      case "남성":
        imageAddress = 'braces';
        break;
      case "여성":
        imageAddress = 'cap';
        break;
      case "슈즈":
        imageAddress = 'sneakers';
        break;
      case "뷰티":
        imageAddress = 'fragance';
        break;
    }
    return Image.asset("assets/images/category_icon/$imageAddress.png",fit: BoxFit.fitWidth);
  }









}