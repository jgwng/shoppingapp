import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopo/kopo.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/select_model.dart';
import 'package:shoppingapp/screens/setting_page/local_widget/scroll_behavior.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page/address_book_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/widgets/custom_checkbox.dart';
import 'package:shoppingapp/widgets/text_label_field.dart';

class OrderInfoPage extends StatefulWidget{
  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage>{
  bool userInfoSelect = false;
  bool userAddressSelect = false;
  bool orderAmountSelect = false;
  bool howToPaySelect = false;

  String howToPay = "";
  List<String> howToPayList = ["신용/체크 카드","네이버 페이","토스","페이코","카카오페이","무통장 입금"];
  List<SelectStringModel> howToPayModel = List<SelectStringModel>();


  TextEditingController orderNameController = TextEditingController();
  TextEditingController phoneFirstController = TextEditingController();
  TextEditingController phoneSecondController = TextEditingController();
  TextEditingController phoneThirdController = TextEditingController();
  TextEditingController secondAddressController = TextEditingController();
  TextEditingController pointController = TextEditingController();
  TextEditingController recipientController = TextEditingController();

  FocusNode phoneFirstFocusNode = FocusNode();
  FocusNode phoneSecondFocusNode = FocusNode();
  FocusNode phoneThirdFocusNode = FocusNode();
  FocusNode secondAddressFocusNode = FocusNode();
  FocusNode recipientFocusNode = FocusNode();

  String postNumber = "우편번호";
  String firstAddress = '검색을 통해 주소를 입력하세요';

  bool isDefault = false;
  @override
  void initState() {
    super.initState();
    howToPayModel = List.generate(howToPayList.length,(i) => SelectStringModel(text: howToPayList[i],isSelected:false));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title: "주문 정보 입력",),
      body: GestureDetector(
        onTap: () => unFocus(),
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderUserInfo(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderItemInfo(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderAddressInfo(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              orderAmountField(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
              howToPayInfo(),
              SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderUserInfo(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("주문자 정보",style: AppThemes.textTheme.subtitle1,),
              Container(
                height: 40,
                child: Row(
                  children: [
                    Text("aaaaaaaa | 010-4434-5151",style: AppThemes.textTheme.subtitle2,),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          userInfoSelect = ! userInfoSelect;
                        });
                      },
                      child: Icon(userInfoSelect ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined),
                    )],
                ),
              ),

            ],
          ),

          SizedBox(height: 10,),
          if(userInfoSelect)
          Column(
           children: [
             Row(children: [
               SizedBox(width: 80,
                 child: Text("이름",style: AppThemes.textTheme.bodyText1,),),
               SizedBox(width: 20,),
               Expanded(
                 child: Container(
                   height: 50,
                   padding: EdgeInsets.only(left: 12),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(6.0),
                       border: Border.all(color:Colors.grey)
                   ),
                   child: TextField(
                       decoration: InputDecoration(
                         hintText: "이름",
                         hintStyle: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),
                         border: UnderlineInputBorder(
                             borderSide: BorderSide(
                                 color: Colors.transparent)),
                         enabledBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                                 color: Colors.transparent)),
                         focusedBorder: UnderlineInputBorder(
                             borderSide: BorderSide(
                                 color: Colors.transparent)),
                       )
                   ),
                 ),
               ),
             ],),
             SizedBox(height: 20,),
             phoneNumberField(),
             SizedBox(height: 20,)
           ],
          ),


        ],
      ),
    );
  }

  Widget phoneNumberField(){
    return Row(children: [
      SizedBox(width: 80,
        child: Text("휴대전화",style: AppThemes.textTheme.bodyText1,),),
      SizedBox(width: 20,),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            phonePartField(phoneFirstController,phoneFirstFocusNode,3),
            Text("-"),
            phonePartField(phoneFirstController,phoneFirstFocusNode,4),
            Text("-"),
            phonePartField(phoneFirstController,phoneFirstFocusNode,4),
          ],
        ),
      ),


    ],);
  }

  Widget phonePartField(TextEditingController textEditingController, FocusNode focusNode,int maxLength){
    return Container(
      height: 50,
      width: 60,
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color:Colors.grey)
      ),
      child: TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.transparent)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.transparent)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.transparent)),
          )
      ),
    );
  }

  Widget orderAddressInfo(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        SizedBox(height: 10,),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
                onTap: (){
              setState(() {
                userAddressSelect = ! userAddressSelect;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("배송 정보",style: AppThemes.textTheme.subtitle1,),
                Container(
                  height: 40,
                  child: Icon(userAddressSelect ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined),
                ),


              ],
            )),
          SizedBox(height: 10,),
        if(userAddressSelect)
        Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) =>  AddressBookPage() )),
              child: Container(
                height:40,alignment: Alignment.centerRight,child: Text("주소록 확인하기",style: AppThemes.textTheme.subtitle1,textAlign: TextAlign.right,),),

            ),

            
            SizedBox(height: 10,),
            TextLabelField(controller: recipientController,focusNode: recipientFocusNode,label: "받는 사람",hintText: "수령인",isNumber: false,),
            SizedBox(height: 20,),
            Container(
                child: Row(
                  children: [
                    Text(postNumber,style : AppThemes.textTheme.bodyText1),
                    SizedBox(width: 10,),
                    RaisedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();
                        KopoModel model = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Kopo(),
                            ));

                        if (model != null) {
                          setState(() {
                            postNumber = model.zonecode;
                            firstAddress = model.address;
                            FocusScope.of(context).requestFocus(secondAddressFocusNode);
                          });
                        }
                      },
                      child: Text("주소 검색"),
                    ),
                    SizedBox(width: 10,),

                  ],
                )
            ),
            SizedBox(height: 10),
            Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[700],width: 1)
              ),
              alignment : Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text(firstAddress,style: AppThemes.textTheme.bodyText1,textAlign: TextAlign.left,),
            ),
            SizedBox(height: 10),
            Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[700],width: 1)
              ),
              alignment : Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: secondAddressController,
                  style: AppThemes.textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: "나머지 주소를 입력하세요.",
                    hintStyle: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent)),
                  )
              ),
            ),
            SizedBox(height: 20),
           

          ],
        ),
      ],
    ));
  }
  Widget orderItemInfo(){
    return Container(
      padding : EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height:20),
          Text("주문 품목",style: AppThemes.textTheme.subtitle1,textAlign: TextAlign.left,),
          SizedBox(height : 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(width: 80,height: 80,
                child: Image.asset("assets/images/data_none_page/unicorn.png",fit: BoxFit.cover,),),
              SizedBox(width:10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("상품명이 아주 긴 경우\n\n45000원",style: AppThemes.textTheme.headline1),

                ],
              ),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [

              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6.0)
                  ),
                  child:Text('XL / 퍼플',style : AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey)),
                ),
              ),
            ],
          ),
          SizedBox(height : 20)
        ],
      )
    );
  }
  Widget orderAmountField(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("결제 금액",style: AppThemes.textTheme.subtitle1,),
            Container(
              height: 40,
              child: Row(
              children: [
               Text("${45000-int.parse(pointController.text=="" ? "0" : pointController.text)}원",style: AppThemes.textTheme.headline1.copyWith(color: AppThemes.pointColor),),
                SizedBox(width: 20,),
                 GestureDetector(
                    onTap: (){
                    setState(() {
                      orderAmountSelect = ! orderAmountSelect;
                    });
                    },
                    child: Icon(orderAmountSelect ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined),
                    )],
                    ),
                    ),
                ],
      ),
          SizedBox(height: 10,),
          if(orderAmountSelect)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(width: 80,
                  child: Text("쿠폰",style: AppThemes.textTheme.subtitle1,),),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color:Colors.grey)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("쿠폰을 선택해 주세요",style: AppThemes.textTheme.subtitle1,),
                        Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                ),
              ],),
              SizedBox(height : 20),
              Row(children: [
                SizedBox(width: 80,
                  child: Text("적립금",style: AppThemes.textTheme.subtitle1,),),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color:Colors.grey)
                    ),
                    child: TextField(
                      onChanged: (text) {
                         setState(() {
                           if(int.parse(text) >= 12000){
                             pointController.text = "12000";
                           }
                         });
                      },
                        controller: pointController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "0",
                          suffixIcon: SizedBox(
                              width: 20,height: 20,
                              child : Center(
                            child: Text("원",style: AppThemes.textTheme.bodyText1.copyWith(color: Colors.grey),textAlign: TextAlign.center,),
                        )
                          ),
                          hintStyle: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent)),
                        )
                    ),
                  ),
                ),
              ],),
              SizedBox(height: 20,),
              RichText(textAlign: TextAlign.left,
                text: TextSpan(text: '잔여 적립금 :  ',style : AppThemes.textTheme.bodyText1.copyWith(
                  color: Colors.grey,
                ),children:[
                  TextSpan(text: '12000원',
                      recognizer: TapGestureRecognizer()..onTap =(){
                    setState(() {
                      pointController.text = "12000";
                    });
                      },
                      style : AppThemes.textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,decorationColor: AppThemes.mainColor,color: AppThemes.pointColor))
                ]),
              ),
              SizedBox(height: 15,),
              Divider(color: Colors.grey,height: 1,thickness: 1,),
              SizedBox(height:15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("결제 금액",style: AppThemes.textTheme.subtitle1,),
                  Text("${45000-int.parse(pointController.text=="" ? "0" : pointController.text)}원",style: AppThemes.textTheme.headline1.copyWith(color: AppThemes.pointColor),)
                ],
              ),
              SizedBox(height: 15,),
              Divider(color: Colors.grey,height: 1,thickness: 1,),
              SizedBox(height:15),
              amountListItem("총 상품 금액","45000원"),
              SizedBox(height:10),
              amountListItem("상품 할인","0원"),
              SizedBox(height:10),
               amountListItem("쿠폰/포인트 할인","${ pointController.text}원"),
              SizedBox(height:10),
              amountListItem("배송비","2000원"),
              SizedBox(height:20),
            ],
          )

    ]));
  }
  Widget amountListItem(String title, String money){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: AppThemes.textTheme.subtitle1.copyWith(color:Colors.grey),),
        Text(money,style: AppThemes.textTheme.subtitle1,),
      ],);
  }

  Widget howToPayInfo(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("결제 수단",style: AppThemes.textTheme.subtitle1,),
                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Text(howToPay,style: AppThemes.textTheme.bodyText1,),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            howToPaySelect = ! howToPaySelect;
                          });
                        },
                        child: Icon(howToPaySelect ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined),
                      )],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            if(howToPaySelect)
              Container(
                height:270,
              child:Column(
              children: [
              SizedBox(height:20),
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  crossAxisCount:2,
                  childAspectRatio: 140/50,
                  crossAxisSpacing: 30.0,
                  mainAxisSpacing: 30.0,
                  shrinkWrap: true,
                  children: List.generate(6, (index){
                    return howToPayListItem(howToPayModel[index]);
                  })
              ),
            ),
          ]
        )
              )
              ,
          ],
        ));
  }

  Widget howToPayListItem(SelectStringModel selectStringModel){
    return GestureDetector(
      onTap: (){
        setState(() {
          howToPayModel.forEach((element) => element.isSelected = false);
          selectStringModel.isSelected = true;
          howToPay = selectStringModel.text;
        });
      },
      child: Container(
        height: 60,
          alignment : Alignment.center,
          decoration: BoxDecoration(
              color: selectStringModel.isSelected ? AppThemes.mainColor : Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: selectStringModel.isSelected ? AppThemes.mainColor : Colors.black)
          ),
        child: Text(selectStringModel.text,style: AppThemes.textTheme.bodyText1.copyWith(
          color: selectStringModel.isSelected ? Colors.white : Colors.black,
        ),),
      ),
    );
  }

  void unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();

    }
  }
}