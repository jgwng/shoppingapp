import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/models/pointlog.dart';
import 'package:shoppingapp/screens/setting_page/point_info_page/sort_PointLog.dart';
import 'package:shoppingapp/widgets/app_bar/text_title_appbar.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/widgets/custom_radio.dart';
class PointInfoPage extends StatefulWidget{
  @override
  _PointInfoPageState createState() => _PointInfoPageState();
}

class _PointInfoPageState extends State<PointInfoPage> with AutomaticKeepAliveClientMixin{
  int selectUsageValue = 0;
  List<PointLog> totalList = [];
  List<PointLog> usePointList = [];
  List<PointLog> addPointList = [];
  List<PointLog> displayList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var a = PointLog(useTitle: "상품 결제",useSubtitle: "상품 주문 : 챔피온 티셔츠 외 1개",createdAt: DateTime.now(),useAmount: 876,usePoint: true);
    var b = PointLog(useTitle: "상품 결제",useSubtitle: "상품 주문 : 챔피온 티셔츠 외 1개",createdAt: DateTime.now(),useAmount: 876,usePoint: false);
    totalList.add(a);
    totalList.add(b);
    displayList = totalList;




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TextTitleAppBar(title: "적립금",),
      body: Consumer(
        builder : (context,watch,child){
    return FutureBuilder(
    future: getData(context),
    builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        if(snapshot.data == null){
          return Center(
            child: Column(
              children: [
                SizedBox(height: size.height * .25,),
                Image.asset('assets/images/data_none_page/unicorn.png'),
                Text("데이터가 없습니다.", style: AppThemes.textTheme.headline2.copyWith(fontSize: 21, color: AppThemes.inActiveColor),),
                SizedBox(height: size.height * .25,),
              ],
            ),
          );
        }
        else if(snapshot.data[0] == -1){
          return Center(
            child: Column(
              children: [
                SizedBox(height: widgetHeight(264)),
                Text(
                    "데이터를\n가져오지 못하였습니다",
                    textAlign: TextAlign.center,
                    style: AppThemes.textTheme.bodyText1.copyWith(fontSize: 21)
                ),
                SizedBox(height: 11),
                Text("와이파이 연결 후 다시 시도해주세요.",textAlign: TextAlign.center, style: AppThemes.textTheme.bodyText1.copyWith(color: AppThemes.inActiveColor))
              ],
            ),
          );
        }
        else{
          totalList = snapshot.data[0];
          usePointList = snapshot.data[1];
          addPointList = snapshot.data[2];
          return buildBody();
        }
      }
      return Center(child: CircularProgressIndicator());


    }
    );
    })

      );
  }


  Widget buildBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
          Container(
            height: 80,
            alignment: Alignment.center,
            padding : EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("적립금",style : AppThemes.textTheme.headline2),
                Text("15000원",style : AppThemes.textTheme.headline2.copyWith(color: AppThemes.pointColor)),
              ],
            ),
          ),
          SizedBox(height: 20,child: Container(color: Colors.grey[200],),),
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 24),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text("적립금 내역",style: AppThemes.textTheme.bodyText1,),
                selectUsageTile(0, "전체"),
                selectUsageTile(1, "사용"),
                selectUsageTile(2, "적립"),
              ],
            ),
          ),
          Divider(height: 1,thickness: 1,color: Colors.grey[200],),
          ListView.separated(
            itemCount: displayList.length,
            shrinkWrap: true,
            itemBuilder: (ctx, i) => pointUsageInfo(displayList[i]),
            separatorBuilder: (ctx,i)=> Divider(height: 1,thickness: 1,color: Colors.grey[200],),
          ),








        ],
      ),
    );
  }







  Row selectUsageTile(int value, String usage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10,),
        SizedBox(
          width: 24,
          height: 24,
          child: CustomRadio(
              value: value,
              groupValue: selectUsageValue,
              onChanged: (newValue) {
                setState(() {
                  selectUsageValue = newValue;
                  switch(newValue){
                    case 0:
                      displayList =totalList;
                      break;
                    case 1:
                      displayList = addPointList;
                      break;
                    case 2:
                      displayList = usePointList;
                      break;
                  }
                });
              },
              activeColor: AppThemes.mainColor,
              backgroundColor: Colors.white,
              inactiveColor:Colors.grey
          ),
        ),
        SizedBox(width: 5,),
        Text(
          usage,
          style:AppThemes.textTheme.subtitle2,
        )
      ],
    );
  }
  
  Widget pointUsageInfo(PointLog pointLog){
    bool addOrUse = (pointLog.usePoint) ? true : false;
    String plusOrMinus = (pointLog.usePoint) ? "+" : "-";
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 40,
                padding: EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: addOrUse ? Colors.blue[800] : Colors.red[800],width: 2)
                ),
                child: Text(addOrUse ? "적립" : "사용" ,style: AppThemes.textTheme.bodyText1.copyWith(color: addOrUse ? Colors.blue[800] : Colors.red[800]),),
              ),
              SizedBox(width: 24,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(conversionDateTime(pointLog.createdAt),style: AppThemes.textTheme.subtitle2.copyWith(color: Colors.grey),),
                  SizedBox(height: 5,),
                  Text(pointLog.useTitle,style: AppThemes.textTheme.bodyText1),
                  SizedBox(height: 8,),
                  Text(pointLog.useSubtitle,style: AppThemes.textTheme.bodyText2.copyWith(color: Colors.black45))
                ],
              )
            ],
          ),
          Text(plusOrMinus+pointLog.useAmount.toString()+"P",style: AppThemes.textTheme.headline1.copyWith(color: addOrUse ? Colors.blue[800] : Colors.red[800]))
        ],
      ),
    );
  }

  String conversionDateTime(DateTime dateTime){

    String newFormat = DateFormat("yyyy.MM.dd").format(dateTime);

    return newFormat;
  }

  Future<List<dynamic>> getData(BuildContext context) async {
    List<dynamic> result = [];
    try{
      final connectivity = await InternetAddress.lookup('google.com');
      if (connectivity.isNotEmpty && connectivity[0].rawAddress.isNotEmpty) {
        result = sortPointLog(totalList);
      }

    }
    catch(e){
      result = [-1];
    }
    print(result);
    return result;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}