import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/models/cart.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/custom_snackbar.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductOptionSelectPage extends StatefulWidget{
  ProductOptionSelectPage({Key key, this.isCart = false,this.productName,this.productPrice = 50000}) : super(key: key);
  final bool isCart;
  final String productName;
  final num productPrice;
  @override
  _ProductOptionSelectPageState createState() => _ProductOptionSelectPageState();
}

class _ProductOptionSelectPageState extends State<ProductOptionSelectPage> {
  OverlayEntry _overlayEntry;
  OverlayState _overlayState;

  OverlayEntry _overlayEntry1;
  OverlayState _overlayState1;

  bool selectTop = false;
  bool isOpened = false;
  String option1 = '옵션1 선택';
  String option2 = '옵션2 선택';
  int itemCount = 1;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    super.initState();
    _overlayState = Overlay.of(context);
    _overlayState1 = Overlay.of(context);
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
      key: scaffoldKey,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30,),
            Text("옵션을 선택해 주세요",style: AppThemes.textTheme.bodyText1,),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()  {
                if(isOpened){
                  _overlayEntry.remove();
                  _overlayEntry = null;
                }else{
                  _overlayEntry = _createOverlayEntry(_overlayEntry,_overlayState);
                  _overlayState.insert(_overlayEntry);
                }
                setState(() {
                  isOpened = !isOpened;
                  selectTop = true;
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: AppThemes.mainColor,width: 1)
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(option1,textAlign: TextAlign.center,style: AppThemes.textTheme.subtitle2,),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()  {
                if(selectTop){

                }else{
                  if(isOpened){
                    _overlayEntry1.remove();
                    _overlayEntry1 = null;
                  }else{
                    _overlayEntry1 = _createOverlayEntry(_overlayEntry1,_overlayState1);
                    _overlayState1.insert(_overlayEntry1);
                  }
                  setState(() {
                    isOpened = !isOpened;
                    selectTop = false;
                  });
                }

              },
              child: Container(
                height: 40,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: AppThemes.mainColor,width: 1)
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(option2,textAlign: TextAlign.center,style: AppThemes.textTheme.subtitle2,),
              ),
            ),
            SizedBox(height: 10,),
            Visibility(
              visible: widget.isCart ? false : true,
              child: Container(height: 80,
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
                ),),
            )
          ],
        ),
      ),
      bottomNavigationBar: (widget.isCart) ? optionChangeButton() : Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            bottomNavigationButton("장바구니", addCart),
            bottomNavigationButton("바로 구매", () { }),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry(OverlayEntry overlayEntry,OverlayState overlayState){
    RenderBox renderBox = context.findRenderObject();

    var offset = renderBox.localToGlobal(Offset.zero);
    print(offset.dx);
    print(offset.dy);
    return OverlayEntry(maintainState: true,builder:(context) =>
        Positioned(
          left: offset.dx+24,
          top: (overlayEntry == _overlayEntry) ? offset.dy-40 : offset.dy-90,
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
              itemBuilder: (ctx,i) => optionSelectListItem(overlayEntry,overlayState,i),
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

  Widget optionSelectListItem(OverlayEntry overlayEntry,OverlayState overlayState,int index){
    return GestureDetector(
        onTap: (){
          overlayState.setState(() {
            setState(() {
              print("overlayState : ${index.toString()}");
              isOpened = false;
              (selectTop) ? option1 = 'AAAAAAAA' : option2 = 'AAAAAAAA';

            });
          });
          (selectTop) ? _overlayEntry.remove() : _overlayEntry1.remove();
          (selectTop) ? _overlayEntry = null : _overlayEntry1 = null;
          setState(() {
            selectTop = false;
          });
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




  void addCart() async{
    if((option1 == '옵션1 선택') | (option2 == '옵션2 선택')){
      scaffoldKey.currentState.showSnackBar(CustomSnackBar(
        backgroundColor: AppThemes.mainColor,
        content: Text("옵션을 모두 선택해 주시기 바랍니다.",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.white),),));
    }else{
      Cart cart = Cart(price: widget.productPrice,option: [option1,option2],productName: widget.productName);

      await context.read(firestoreProvider).addCart(cart);
      Navigator.pop(context, "장바구니 추가");
    }
  }




  Widget optionChangeButton(){
    return Container(
      height :60,
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
      child: RaisedButton(
        elevation: 0,
        color: AppThemes.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        onPressed: () async{
          if((option1 !='옵션1 선택' ) & (option2 !='옵션2 선택')){

            Cart cart = Cart(price: widget.productPrice,option: [option1,option2],productName: widget.productName);
            await context.read(firestoreProvider).addCart(cart);
            Navigator.pop(context,option1 + "/" + option2);

          }else{
            scaffoldKey.currentState.showSnackBar(CustomSnackBar(
              backgroundColor: AppThemes.mainColor,
              content: Text("옵션을 변경해 주시기 바랍니다.",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.white),),));
          }
        },
        child: Text("옵션 변경하기",style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.white),),
      ),
    );
  }

  @override
  void dispose() async{
    super.dispose();
    _overlayEntry?.remove();
    _overlayEntry1?.remove();
    print("AAAAA");

  }

  void didPush() async{
    print("AAA");
    if((_overlayEntry != null) | (_overlayEntry1 != null)){

    }
  }

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