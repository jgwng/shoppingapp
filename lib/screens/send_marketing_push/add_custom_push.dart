import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/select_age_model.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';

class AddMarketingPush extends StatefulWidget{
  @override
  _AddMarketingPushState createState() => _AddMarketingPushState();
}

class _AddMarketingPushState extends State<AddMarketingPush>{
  TextStyle textStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w500,fontSize:18, color: Color.fromRGBO(42, 42, 42, 1.0));
  bool gender = false;
  int genderValue = -1;
  List<int> ageList = [1,2,3,4,5,6];
  List<SelectAgeModel> standardAge = List<SelectAgeModel>();
  List<int> selectedAge = List<int>();
  TextEditingController fcmTitleController = TextEditingController();
  TextEditingController fcmContentController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    standardAge = List.generate(ageList.length,(i) => SelectAgeModel(age: ageList[i],isSelected: false));
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TextTitleAppBar(title:"푸시메세지 추가"),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              setFCMMessage("제목",fcmTitleController),
              setFCMMessage("내용",fcmContentController),
              SizedBox(height: 10,),
              _selectGender(),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 24,),
                  Expanded(
                      child:  Text("연령대",style: textStyle,)),
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overScroll){
                      overScroll.disallowGlow();
                      return;
                    },child:  Container(
                      height: 120,
                      width: 300,
                      child: GridView.count(
                      padding: EdgeInsets.only(left: 24,right: 24,top: 10),
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 20/12,
                      children: List.generate(ageList.length,(index){
                        return ageSelectButton(standardAge[index],index);
                      }
                      ),
                    ),
                  ),)
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  SizedBox(width: 24,),
                  Expanded(
                      child:  Text("시간",style: textStyle,)),
                  Container(
                    width : 274,
                    height: 190,
                    child:  CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(1969, 1, 1,10, 0),
                      onDateTimeChanged: (DateTime newDateTime) {
                        print(newDateTime);
                      },
                      use24hFormat: false,
                      minuteInterval: 60,
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 24,right: 24,bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bottomButton("미리보기", () {}),
            bottomButton("설정하기", () {}),
          ],
        ),
      ),
    );
  }


  Widget setFCMMessage(String labelText,TextEditingController textEditingController){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 24,),
            Expanded(
                child:  Text(labelText,style: textStyle,)),
            Container(
              width : 274,
              padding: EdgeInsets.only(right: 24),
              child:  TextField(
                controller: textEditingController,
              ),
            )
          ],
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget _selectGender(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 24,),
        Expanded(
            child:  Text("성별",style: textStyle,)),
        SizedBox(
          width: 276,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:  genderTile(1,"남성"),
              ),
              Expanded(
                child:  genderTile(2,"여성"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row genderTile(int value, String genderText) {
    return Row(
      children: [
        CustomRadio(
            value: value,
            groupValue: genderValue,
            onChanged: (newValue) {
              setState(() {
                genderValue = newValue;
                if(newValue ==1){
                  gender = true;
                }else{
                  gender = false;
                }

              });
            },
            activeColor: AppThemes.mainColor,
            backgroundColor: Colors.white,
            inactiveColor:Colors.grey
        ),
        SizedBox(width: 9),
        Text(
          genderText,
          style:TextStyle( color: Color.fromRGBO(42, 42, 42, 1.0),fontSize: 16
          ),
        )
      ],
    );
  }

  Widget ageSelectButton(SelectAgeModel selectModel,int index) {
    return GestureDetector(
        onTap: (){
          setState(() {
            (selectModel.isSelected) ? selectedAge.remove(index) : selectedAge.add(index);
            selectModel.isSelected = !selectModel.isSelected;
          });
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: selectModel.isSelected ? AppThemes.mainColor : Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              padding: const EdgeInsets.all(5.0),
              child:Center(
                child : Text(
                  (selectModel.age*10).toString()+"대",textAlign: TextAlign.center,
                  style: textStyle.copyWith(fontSize: 16),
                ),
              )
          ),
        )
    );
  }

  Widget bottomButton(String buttonText, VoidCallback onPressed){
    return Container(
        width: 160,
        height: 50,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          onPressed: onPressed,
          child : Text(buttonText,style:  GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.black)),)
    );
  }



}