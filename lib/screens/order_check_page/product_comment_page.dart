import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'dart:math' as math;

class ProductCommentPage extends StatefulWidget{
  @override
  _ProductCommentPageState createState() => _ProductCommentPageState();
}

class _ProductCommentPageState extends State<ProductCommentPage>{
  List<bool> starList = [false,false,false,false,false];
  int starCount = 0;
  FocusNode contentFocusNode = FocusNode();
  TextEditingController contentController = TextEditingController();
  double _inputHeight = 170;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    contentController.addListener(_checkInputHeight);
    contentController.addListener(_onFocusChange); // 엔터 여부 확인 위해 설정
  }

  void _onFocusChange() async {
    setState(() {
      isFocused = !isFocused;
    });
  }

  void _checkInputHeight() async {
    int count = contentController.text.split('\n').length; // 사용자의 엔터 입력 확인
    if (count == 0 && _inputHeight == 170.0) {
      return;
    }
    if (count <= 5) {
      // use a maximum height of 6 rows
      // height values can be adapted based on the font size
      var newHeight = count == 0 ? 170.0 : 28.0 + (count * 28.0);
      setState(() {
        _inputHeight = newHeight;
      });
    } // 사용자의 엔터 입력에 따른 질문 내용의 textfield 크기 증가 & 감소
  }

  @override
  void dispose() {

    contentController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: TextTitleAppBar(title: "제품 후기 작성"),
     body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
         Container(
           alignment: Alignment.center,
           child: Text("상품에 대해 만족하시나요?",style: AppThemes.textTheme.headline1.copyWith(fontWeight: FontWeight.w700),),
         ),
         SizedBox(height: 40,),
         Container(
           height: 50,
           alignment : Alignment.center,
           child: Center(
             child : ListView.separated(

                shrinkWrap: true,
               itemBuilder: (ctx,i) => starIcon(i),
               separatorBuilder:(ctx,i) => SizedBox(width: 10,),
               itemCount: 5,
               scrollDirection: Axis.horizontal,)
           ),
         ),
          SizedBox(height: 40,),
          contentField(),
          SizedBox(height: 30,),
          addImage(),
        ],
      ),
     ),
   );
  }

  Widget starIcon(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          starCount = index;
          starList.asMap().forEach((i, value) => {
            starList[i] = (i<=index) ? true : false
          });
          print(index);

        });
      },
      child: (starList[index]) ? Icon(Icons.star_outlined,size: 50,color: AppThemes.pointColor,) : Icon(Icons.star_border_outlined,size: 50,),
    );
  }

  Widget contentField() {
    return Align(
    alignment: Alignment.center,
      child: Container(
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
          style: AppThemes.textTheme.subtitle1
              .copyWith(height: 1.5, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 7, //
          maxLines: 10, //최대 줄수 설정을 통한 줄바꿈 횟수 제한
          controller: contentController,
          decoration: InputDecoration(
              hintText: "리뷰를 입력해주세요!",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15)),
        ),
      ),
    );
  }

  Widget addImage(){
    return Container(
      padding: EdgeInsets.only(left:25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("사진 첨부",style: AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),),
          SizedBox(height: 10,),
          Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.only(left:3,bottom:3),

            child:Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(Icons.add_a_photo_rounded, size: 45,),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.black)
            ),
          )
        ],
      ),
    );
  }

}