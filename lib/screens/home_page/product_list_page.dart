import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/search_bar.dart';
import 'package:shoppingapp/widgets/product_item.dart';
class ProductListPage extends StatefulWidget{
  ProductListPage({Key key, this.category,this.onPush}) : super(key: key);
  final String category;
  final Function onPush;
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
                      return ProductItem(onPush: widget.onPush,);
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

}