import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/models/SelectAgeModel.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';

class SendMarketingPush extends StatefulWidget{
  @override
  _SendMarketingPushState createState() => _SendMarketingPushState();
}

class _SendMarketingPushState extends State<SendMarketingPush>{
  TextStyle textStyle =  GoogleFonts.notoSans(fontWeight: FontWeight.w500,fontSize: 15, color: Color.fromRGBO(42, 42, 42, 1.0));
  bool gender = false;
  int genderValue = -1;
  List<int> ageList = [10,20,30,40,50,60];
  List<SelectAgeModel> standardAge = List<SelectAgeModel>();
  List<int> selectedAge = List<int>();

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
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            _selectGender(),
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
                    height:100,
                    width: 300,
                  child: GridView.count(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 10),
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 20/10,
                    children: List.generate(ageList.length,(index){
                      return ageSelectButton(standardAge[index],index);
                    }
                    ),
                  ),
                ),)
              ],
            ),
            Container(
              width : 200,
              height: 200,
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
      )
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
          width: 300,
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

  Widget selectAge(int index){
    return SizedBox(
      width: 100,
      height: 40,
      child : RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(index.toString()),
      )
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
          style:TextStyle( color: Color.fromRGBO(42, 42, 42, 1.0)
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
                  selectModel.age.toString(),textAlign: TextAlign.center,
                  style: textStyle,
                ),
              )
          ),
        )
    );
  }





}