import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/home_page/product_detail_page.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/search_bar.dart';

class ProductListPage extends StatefulWidget{
  ProductListPage({Key key, this.category}) : super(key: key);
  final String category;
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>{
  bool selected = false;

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
    appBar: TextTitleAppBar(title : widget.category),
    body: NotificationListener<OverscrollIndicatorNotification>(
    onNotification: (OverscrollIndicatorNotification overScroll) {
    overScroll.disallowGlow();
    return false;
    },child: GestureDetector(
        onTap : () => unFocus(),
        child : SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   Container(
                      padding: EdgeInsets.only(left: 20),
                      width : widgetHeight(370),
                      height: 40,
                      child: SearchBar(suffixIconOnTab: onClear,controller: searchController,focusNode: focusNode,),
                    ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: filterTouched,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.filter_alt_rounded,size:40),
                    ),
                  )

                ],
              ),
              SizedBox(height: 30,),
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),

                    crossAxisCount:2,
                    //childAspectRatio : width/height
                    childAspectRatio: 180/200,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(8, (index){
                      return productItem();
                    })
                ),
              )
        ],
      ),
    ),))
  );
  }

  void onClear(){
    setState(() {
      searchController.clear();
    });
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void filterTouched() async{
      int result = await onSortStandardPickerBottomSheet(context,0);
      if(result != null){
        print(result);
      }

  }



  Widget productItem(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(c) => ProductDetailScreen()));
      },child: Container(
      height: widgetHeight(200),
      width: 160,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6.0)
                ),

              ),

              Positioned(
                right: 3,
                top: 3,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: (selected) ? Icon(Icons.favorite,color: AppThemes.pointColor,size: 35,) : Icon(Icons.favorite_border_outlined,size: 35,color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Text("제품명"),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("할인율"),
              SizedBox(width: 20,),
              Text("가격")
            ],
          )
        ],
      ),
    ),
    );
  }
}