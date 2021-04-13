import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/widgets/product_image_indicator.dart';
import 'package:shoppingapp/models/product_question.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:shoppingapp/widgets/product_item.dart';
import 'package:shoppingapp/widgets/comment_image_dialog.dart';
import 'package:shoppingapp/widgets/custom_snackbar.dart';
import 'package:shoppingapp/screens/home_page/product_option_select_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/providers/firestore_provider.dart';

class ProductDetailScreen extends StatefulWidget{
  ProductDetailScreen({Key key, this.product}) : super(key: key);
  final Product product;


  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin{
  int widgetIndex = 0;
  int currentSelectedCommentIndex=0;
  bool isFavorite = false;
  bool isTouched = false;
  final PageController controller = PageController(initialPage: 0);
  final PageController commentPageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();

  List<String> deliveryInfo = ["출고일정은 상품별 상세페이지에서 확인하실 수 있습니다.","도서산간 지역은 추가 배송비 입금 요청이 있을 수 있습니다."];
  List<String> refundInfo = ["교환,환불 및 기타문의는 고객센터 1234-5678으로\n문의주셔야 합니다.","단순변심으로 인한 교환/환불인 경우 반송비를 입금해\n주셔야 합니다.",
    "상품 불량인 경우 배송비를 포함한 전액이 환불됩니다.","상품 수령일로부터 7일 이내 반품/환불 접수 가능합니다.","출고 이후 환불요청 시 상품 회수 후 처리됩니다."];

  String category = "질문유형을 선택해 주세요";


  List<String> commentImageList = ['hoodie','cap','braces','dress','sneakers','fragance'];



  TextEditingController contentController = TextEditingController();
  double _inputHeight = 100.0;
  FocusNode contentFocusNode = FocusNode();
  ProductQuestion productQuestion;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contentController.addListener(_checkInputHeight);
    productQuestion = ProductQuestion(createdAt: DateTime.now(),question: "문의 질문 드립니다.", answer: "문의 답변 드립니다.",isAnswered: false,isSelected: false);
    currentSelectedCommentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title : "제품 상세"),
      body: ListView(
        controller: scrollController,
        children: [
          productImage(),
          SizedBox(height: 15,),
          Container(
            height :40,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("유저들의 스타일링샷", style: AppThemes.textTheme.headline1,),
              Icon(Icons.arrow_forward_ios,size: 15,)
            ],
          ),),
          SizedBox(height: 15,),
          Container(
            height: 300,
            width: 300,
            alignment: Alignment.center,

            child:PageView.builder(
              onPageChanged: _pageChanged,
              controller: commentPageController,

              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: ()=> Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          CommentImageDialog())),
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: Image.asset("assets/images/category_icon/${commentImageList[index]}.png",fit: BoxFit.contain),
                  ),
                );
              },
              itemCount: commentImageList.length,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 100,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (ctx,i) => SizedBox(width:20,),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,i) => commentListItem(i),
              shrinkWrap: true,
              itemCount: 5,
            ),
          ),
          SizedBox(height:20),
          StickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.white,

              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  stickyTab("상품 설명",0),
                  stickyTab("배송/반품/고시",1),
                  stickyTab("상품 문의",2),],
              ),
            ),
            content: contentWidget(widgetIndex),
          ),
          Padding(padding: EdgeInsets.only(left: 20),child: Text("이런 제품은 어때요?",style: AppThemes.textTheme.headline1),),
          SizedBox(height:20),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(right: 18),
                crossAxisCount:2,
                //childAspectRatio : width/height
                childAspectRatio: 150/180,

                mainAxisSpacing: 5.0,
                shrinkWrap: true,
                children: List.generate(6, (index){
                  return ProductItem();
                })
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20,top: 30),child: Text("함께사면 배송비 절약!",style: AppThemes.textTheme.headline1),),
          SizedBox(height:20),
          Container(
            height: 230,
            child: ListView.builder(
              itemBuilder: (ctx,i)=> ProductItem(),
              itemCount: 8,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 15),
        child: Row(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async{
                (isFavorite) ? await context.read(firestoreProvider).removeFavoriteItem(widget.product) : context.read(firestoreProvider).addFavoriteItem(widget.product);
                setState(() {
                  isFavorite = !isFavorite;

                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.grey)
                ),
                child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline_outlined,size: 30,color: AppThemes.pointColor,),
              ),
            ),
            SizedBox(width: 30,),
            Expanded(
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: () async{
                   String result =  await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.5,
                        child: ProductOptionSelectPage(productName: "AAAAAA",),
                      );
                    });
                   if(result != null){
                     scaffoldKey.currentState.showSnackBar(CustomSnackBar(
                       backgroundColor: AppThemes.mainColor,
                       content: Text("장바구니에 추가 완료!",style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.white),),));
                   }
                  },
                  //> Navigator.push(context,MaterialPageRoute(builder:(c) => OrderInfoPage(productList: [widget.product],)))
                  color: AppThemes.mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)
                  ),
                  child: Text("구매하기",style:AppThemes.textTheme.headline1.copyWith(color:Colors.white)),
                ),
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          scrollController.jumpTo(0.0);
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_upward,size: 30,color:Colors.black,),
      ),
    );

  }

  Widget stickyTab(String text,int index){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
      setState(() {
        if(widgetIndex != index){
          widgetIndex = index;
          scrollController.jumpTo(1090.0);
          print(widgetIndex);
        }

      });
    },
      child: Container(
        width: (size.width)/3,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,textAlign: TextAlign.center,
              style: AppThemes.textTheme.subtitle2,
            ),
            SizedBox(height: 10,),
            Divider(color: (widgetIndex == index) ? Colors.black : Colors.transparent,height: 2,thickness: 1,)
          ],
        ),
      ),);
  }

  Widget commentListItem(int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelectedCommentIndex = index;
          commentPageController.jumpToPage(index);
        });

      },
      child: Container(
        width: 100, height: 100,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color:currentSelectedCommentIndex == index ? AppThemes.mainColor: Colors.transparent,width: 4)
        ),
        child: Image.asset("assets/images/category_icon/${commentImageList[index]}.png",fit: BoxFit.scaleDown),
      ),
    );
  }


  Widget contentWidget(int index){
    switch(index){
      //제품 착용 관련 이미지 나열 페이지
      case  0:
        return Container(height:(isTouched) ? 710 : 605,
        child: Column(
          children: [
            Container(
              height  :(isTouched) ? 605 : 500,
              child: ListView.builder(
              controller: scrollController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              shrinkWrap: false,
              itemBuilder: (ctx,i) => Container(height: 300,child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.contain),
              ),),
            ),),
            if(!isTouched)
            Container(
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 25,horizontal: 30),
                child:  RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  onPressed:(){
                  setState(() {
                  isTouched = true;
                  });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("상품 설명 더 보기",style: AppThemes.textTheme.bodyText1,),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_drop_down,size: 35,),
                          SizedBox(height: 3,)
                        ],
                      )
                    ],
                  ),
             ),
            ),
          ],
        )





        ,);
        break;
       //배송,교환,환불정보 관련 내용
      case 1:
        return Container(
          height: 380,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noticeInfo("배송 정보", deliveryInfo),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Divider(height: 1,thickness: 1,color: Colors.black,),),
              noticeInfo("교환/환불/AS안내/기타",refundInfo)
          ],
        ),);
        break;
      case 2:
        return askProduct();
        break;
    }
    return Container();
  }


  Widget askProduct(){
    return  Container(
      height  : 500,
        child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
           padding: EdgeInsets.symmetric(horizontal: 24),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("문의 내용 작성",style: AppThemes.textTheme.bodyText1,),
               SizedBox(height :10),
               GestureDetector(
                 onTap: () async{
                   String result =  await onInquiryCategoryPickerBottomSheet(context);
                   if(result != null){
                     setState(() {
                       category = result;
                     });
                   }
                 },
                 child: Container(
                   height : 40,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(6.0),
                       border: Border.all(color : Colors.black)
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(category,style:  AppThemes.textTheme.bodyText1,),
                       Icon(Icons.arrow_drop_down,size:30)
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 10,),
               Container(
                 padding: EdgeInsets.only(top: 15, bottom: 25.5),
                 width: size.width-50,
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   color: Color.fromRGBO(142, 142, 147, 0.24),
                   border: Border.all(color: Color.fromRGBO(204, 204, 204, 1.0), width: 1),
                   borderRadius: BorderRadius.circular(5.0),
                 ), //내용부분 UI
                 child: TextFormField(
                   focusNode: contentFocusNode,
                   style: AppThemes.textTheme.bodyText1,
                   keyboardType: TextInputType.multiline,
                   textInputAction: TextInputAction.newline,
                   minLines: 7, //
                   maxLines: 10, //최대 줄수 설정을 통한 줄바꿈 횟수 제한
                   controller: contentController,
                   decoration: InputDecoration(
                       hintText: "문의 내용을 작성해주세요!",
                       hintStyle: AppThemes.textTheme.bodyText1.copyWith(color:Colors.grey),
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none,
                       contentPadding: EdgeInsets.symmetric(horizontal: 15)),
                 ),
               ),
               SizedBox(height: 15,),
               Container(
                 width: double.infinity,
                 height: 40,
                 child: RaisedButton(
                   onPressed: (){},
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(6.0),
                   ),
                   color: AppThemes.mainColor,
                   child: Text("문의 등록하기",style: AppThemes.textTheme.bodyText1.copyWith(color:Colors.white),),
                 ),
               ),
               SizedBox(height: 15),
             ],
           ),
         ),
          SizedBox(height: 20,child: Container(color:Colors.grey[200])),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text("Q&A",style : AppThemes.textTheme.bodyText1),
          ),
            SizedBox(height:10),
            questionListItem(productQuestion),
            SizedBox(height:20,child: Container(color: Colors.grey[200],),)
        ],
      )
    );



  }

  void _checkInputHeight() async {
    int count = contentController.text.split('\n').length; // 사용자의 엔터 입력 확인
    if (count == 0 && _inputHeight == 100.0) {
      return;
    }
    if (count <= 5) {
      var newHeight = count == 0 ? 100.0 : 28.0 + (count * 28.0);
      setState(() {
        _inputHeight = newHeight;
      });
    } // 사용자의 엔터 입력에 따른 질문 내용의 textfield 크기 증가 & 감소
  }


  Widget noticeInfo(String title,List<String> textList){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: AppThemes.textTheme.headline1,),
        SizedBox(height: 15,),
        Container(
          height: title == "배송 정보" ? 50 : 200,
          child: ListView.separated(
            itemBuilder: (ctx,i) => noticeListItem(i,textList),
            itemCount: textList.length,
            controller: scrollController,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (ctx,i) => SizedBox(height: 10),
          ),
        )
      ],
    );
  }
  Widget noticeListItem(int index,List<String> textList){
    return Row(
      children: [
        Container(
          height: textList[index].contains('\n')? 25 : 10,
          alignment: Alignment.topCenter,
          child: Icon(Icons.fiber_manual_record,size: 8,),
        ),
        SizedBox(width: 5,),
        Text(textList[index],style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 14),)
      ],
    );
  }

  void _pageChanged(int index) {
    setState(() {});
  }
  Widget productImage(){
    return Container(
      height: 570,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },child :
          Column(
            children: [
              Container(
                height: 350,
                width: 350,
                alignment: Alignment.center,

                child:PageView.builder(
                  onPageChanged: _pageChanged,
                  controller: controller,

                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 300,
                      height: 300,
                      child: Image.asset("assets/logo/grocery-cart.png",fit: BoxFit.fitWidth),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              Indicator(
                controller: controller,
                itemCount: 5,
              )
            ],
          )
          ),

          SizedBox(height: 30,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.product.title}",style: AppThemes.textTheme.headline2,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 10),
                  Text('${widget.product.price.toInt()}원',style: AppThemes.textTheme.headline2,),
                ],
              )
          ),
          SizedBox(height: 20),
          Divider(height: 2,thickness: 1,color: AppThemes.mainColor,),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productPriceInfo("적립금","100원"),
                SizedBox(height: 10,),
                productPriceInfo("배송비","2000원"),
                SizedBox(height: 10,),
                productPriceInfo("예상 도착일",conversionDateTime(DateTime.now())),
              ],
            ),
          )

        ],
      )
    );
  }

  String conversionDateTime(DateTime dateTime){
    DateTime arriveDate = DateTime(dateTime.year,dateTime.month,dateTime.day+2);
    String newFormat = DateFormat("MM월 dd일").format(arriveDate);

    return newFormat;
  }

  Widget productPriceInfo(String label,String content){
    return Row(children: [
      SizedBox(
        width: 80,
        child: Text(label,style: AppThemes.textTheme.bodyText1.copyWith(color:Colors.grey)),
      ),
      SizedBox(width: 20,),
      Text(content,style: AppThemes.textTheme.bodyText1)
    ],);
  }

  Widget questionListItem(ProductQuestion productQuestion){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("2021.02.03 11:11",style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.grey[400]),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Container(
                    width: 80,height: 20,color: Colors.black,alignment: Alignment.center,
                    child : Text(productQuestion.isAnswered ? "답변 완료" : "답변 대기",textAlign: TextAlign.center,style : AppThemes.textTheme.bodyText2.copyWith(color: Colors.white))),
                SizedBox(width: 20,),
                Text("${productQuestion.category} 질문 드립니다",style: AppThemes.textTheme.bodyText2,)
              ],),
              Icon(Icons.arrow_drop_down,size: 20,color: Colors.black,)
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1,thickness: 1,color: Colors.grey,),),

          if(productQuestion.isAnswered && productQuestion.isSelected)
            Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            child: Text("aaaa"),
          )
        ],
      ),
    );
  }



}
//https://flutter-examples.com/set-text-overflow-ellipsis-text-in-flutter/

