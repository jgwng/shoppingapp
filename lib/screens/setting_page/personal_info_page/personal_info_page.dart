import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page/address_book_page.dart';
import 'package:shoppingapp/screens/setting_page/personal_info_page/set_refund_account_page.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/utils/validators.dart';
import 'package:shoppingapp/utils/bottom_sheet.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/main.dart';
import 'package:shoppingapp/utils/keyboard_pop.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/providers/user_provider/user_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/models/user.dart';


class PersonalInfoPage extends StatefulWidget{
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> with RouteAware{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  OverlayEntry _overlayEntry;
  OverlayState _overlayState;

  int text = 0;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // routeObserver is the global variable we created before
    routeObserver.subscribe(this, ModalRoute.of(context));
    print("ChangeDependencies");
  }

  @override
  void dispose() async{
    super.dispose();

    _overlayEntry?.remove();
    routeObserver.unsubscribe(this);
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

  int imageIndex = 0;
  DateTime age;
  num birthYear;
  String birthMD;
  String birthday = "생년월일을 입력하세요.";
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  TextStyle textStyle =  AppThemes.textTheme.bodyText1.copyWith(fontSize: 16,
      color: Color.fromRGBO(
          42, 42, 42, 1.0));

  @override
  void initState(){
    super.initState();
    User user = context.read(userStateProvider).currentUser;
    nameController.text = user.name;

    _overlayState = Overlay.of(context);
  }



  @override
  Widget build(BuildContext context) {
    print("AAAAAAAA");


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title:"개인정보 변경"),
      body:Consumer(builder : (context,watch,child){
        return buildBody(context,watch(userStateProvider));
      }),
      bottomNavigationBar: Container(
        child: Row(
          children: [
          bottomNavigationButton("로그 아웃"),
          bottomNavigationButton("회원 탈퇴"),
          ],

        ),
      ),

    );
  }

  Widget buildBody(BuildContext context, UserState userState){
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },child: SingleChildScrollView(

      child: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: ()  {

                    _overlayEntry = _createOverlayEntry();
                    _overlayState.insert(_overlayEntry);
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: Center(
                      child : SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset("assets/images/avatar_image/boy_$imageIndex.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 160,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10,right: 10,bottom:10),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent)),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text("*캐릭터를 눌러서 이미지를 변경해 보아요!",style: AppThemes.textTheme.subtitle2.copyWith(color:Colors.grey),),
                SizedBox(height:15),
              ],
            ),
            SizedBox(height:20,child: Container(color: Colors.grey[200],),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height:30),
                  infoField(phoneNumberController,phoneNumberFocusNode,"(-) 없이",validatePhoneNumber,true,"휴대폰"),
                  SizedBox(height:40),
                  _inputBirthDay(),
                  SizedBox(height: 30,),
                  labelField("자주 쓰는 배송지 관리"),
                  SizedBox(height: 10,),
                  labelField("기본 환불 계좌 설정"),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
    );
  }



  Widget infoField(TextEditingController textEditingController,
      FocusNode focusNode,String hintText,Function(String number) function,bool verification,String label){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(label,style: textStyle),
        ),
        SizedBox(width: 20,),
        Expanded(child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color:Colors.grey)
            ),
            child : TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                validator: function,
                style:TextStyle(color: Colors.black),
                keyboardType: (verification) ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 2,
                    minHeight: 2,
                  ),

                  suffixIcon: (verification) ? GestureDetector(
                    onTap :(){
                      print("aaa");
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right:10),
                      child: Text(hintText == "관리자 번호" ? "번호 인증" : "번호 변경",style: textStyle,),
                    ),
                  ) : null,
                  contentPadding: EdgeInsets.only(left:20,bottom:3),
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.black45),
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
            )
        ),),

      ],
    );
  }

  OverlayEntry _createOverlayEntry(){
    return OverlayEntry(maintainState: true,builder:(context) =>
        Positioned(
          top:220,left:50,
          child: Container(
              height: 70,
             padding: EdgeInsets.symmetric(horizontal: 10),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius : BorderRadius.circular(6.0),
               border: Border.all(color:Colors.black,width: 1)
             ),
              child: ListView.separated(
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx,i) => avatarListItem(_overlayEntry,_overlayState,i),
                separatorBuilder: (ctx,i) => SizedBox(width:10),
                scrollDirection: Axis.horizontal,
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
            imageIndex = index;
          });
        });
        overlayEntry.remove();
        _overlayEntry = null;

      },
      child: SizedBox(
          width: 50,
          height : 50,
        child: Image.asset("assets/images/avatar_image/boy_$index.png"))
    );
  }

  Widget _inputBirthDay(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child:  Text("생년월일",style: textStyle,)),
          SizedBox(width: 20,),
          Expanded(

              child: GestureDetector(
                onTap: () async {
                  age = await onBirthdayPickerBottomSheet(context);
                  if(age !=null){
                    setState(() {
                      birthYear = age.year;
                      String month = age.month.toString().padLeft(2, '0');
                      String day = age.day.toString().padLeft(2,'0');
                      birthMD = month + day;
                      birthday = DateFormat('yyyy년 MM월 dd일').format(age);
                    });
                  }

                },
                child: Container(
                  height: 50,

                  padding: EdgeInsets.only(left:20),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(birthday,textAlign: TextAlign.center,style: (birthday != "생년월일을 입력하세요.") ? textStyle.copyWith(color: Colors.black,fontSize: 14) :
                  textStyle.copyWith(color:Colors.grey)),
                ),
              )
          ),
        ]
    );
  }

  Expanded bottomNavigationButton(String text){
    return Expanded(
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: RaisedButton(
                color: AppThemes.mainColor,
                onPressed: (){},
                child: Text(text,style: AppThemes.textTheme.bodyText1.copyWith(color:Colors.white),),
              ),
    ));
  }

  Widget labelField(String text){
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => (text == "기본 환불 계좌 설정") ? RefundAccountPage() : AddressBookPage() )),

        child: Container(
          height : 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: textStyle,),
              Icon(Icons.arrow_right,size: 25,)
            ],
          ),
        )
    );
  }


  //Overlay data 전달 관련
  //https://medium.com/@saiaparna.kunala/flutter-overlay-for-filtering-7000e3ac4f16
  //https://github.com/flutter/flutter/issues/50961


}