import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/utils/keyboard_pop.dart';
import 'package:shoppingapp/constants/app_themes.dart';

class ProductOptionSelectPage extends StatefulWidget{
  @override
  _ProductOptionSelectPageState createState() => _ProductOptionSelectPageState();
}

class _ProductOptionSelectPageState extends State<ProductOptionSelectPage> {
  OverlayEntry _overlayEntry;
  OverlayState _overlayState;
  bool isOpened = false;
  String option = 'Nothing';
  int itemCount = 1;
  @override
  void initState(){
    super.initState();
    _overlayState = Overlay.of(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // routeObserver is the global variable we created before

    print("ChangeDependencies");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100,),
            GestureDetector(
              onTap: ()  {
                if(isOpened){
                  _overlayEntry.remove();
                  _overlayEntry = null;
                }else{
                  _overlayEntry = _createOverlayEntry();
                  _overlayState.insert(_overlayEntry);
                }
                setState(() {
                  isOpened = !isOpened;
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.blue,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(option,textAlign: TextAlign.center,),
              ),
            ),
            SizedBox(height: 10,),
            Container(height: 80,
            padding: EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey[200],
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text("aaaaaaaa",style: AppThemes.textTheme.bodyText1,),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    height: 30,
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: AppThemes.mainColor)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(itemCount !=1){
                                itemCount -=1;
                              }
                            });
                          },
                          child: Text("-",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20, color: itemCount ==1 ? Colors.grey[400] : Colors.black),),),
                        Text("$itemCount",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20),),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              itemCount +=1;
                            });
                          },
                          child: Text("+",style: AppThemes.textTheme.subtitle1.copyWith(fontSize: 20),),
                        ),


                      ],
                    ),
                  ),
                  Text("${50000*itemCount}원",style: AppThemes.textTheme.bodyText1,)
                ],)
              ],
            ),)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            bottomNavigationButton("장바구니", () { }),
            bottomNavigationButton("바로 구매", () { }),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry(){
    RenderBox renderBox = context.findRenderObject();

    var offset = renderBox.localToGlobal(Offset.zero);
    print(offset.dx);
    print(offset.dy);
    return OverlayEntry(maintainState: true,builder:(context) =>
        Positioned(
          left: offset.dx+24,
          top:  offset.dy-90,
          right: offset.dx+24,
          child: Container(
            height: 180,
            width: double.infinity-40,

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius : BorderRadius.circular(6.0),
                border: Border.all(color:Colors.black,width: 1)
            ),
            child: ListView.separated(
              itemCount: 5,
              padding: EdgeInsets.only(top: 5),
              itemBuilder: (ctx,i) => avatarListItem(_overlayEntry,_overlayState,i),
              separatorBuilder: (ctx,i) => Padding(padding:EdgeInsets.symmetric(vertical: 5),child: Divider(
                color: AppThemes.mainColor,thickness: 1,height: 1,
              ),),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ),
        ),
    );
  }

  Widget avatarListItem(OverlayEntry overlayEntry,OverlayState overlayState,int index){
    return GestureDetector(
        onTap: (){
          overlayState.setState(() {
            setState(() {
              print("overlayState : ${index.toString()}");
              isOpened = false;
              option = "AAAAAAAA";
            });
          });
          overlayEntry.remove();
          _overlayEntry = null;

        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity-100,
            height: 60,
            child: Row(children: [
              Text("AAAAAAAA",style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 25,decoration: TextDecoration.none),),
    ],))
    );
  }

  @override
  void dispose() async{
    super.dispose();

    _overlayEntry?.remove();

    print("AAAAA");

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void didPush() async{
    print("AAA");
    if(_overlayEntry != null){
      await keyboardDown(context);
    }
  }

  @override
  void didPopNext() {
    print("AAAA");

  }


  Widget bottomNavigationButton(String title, VoidCallback function){
    return Expanded(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: function,
          //> Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage(productList: [widget.product],)))
          color: AppThemes.mainColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0)
          ),
          child: Text(title,style:AppThemes.textTheme.headline1.copyWith(color:Colors.white)),
        ),
      ),
    );
  }



}