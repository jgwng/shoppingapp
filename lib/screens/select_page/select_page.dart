import 'package:flutter/material.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/constants/size.dart';
import 'package:shoppingapp/screens/main_page.dart';
import 'package:shoppingapp/screens/offline_page/product_scanner.dart';
class SelectOnOrOff extends StatefulWidget {
  @override
  _SelectOnOrOffState createState() => _SelectOnOrOffState();
}

class _SelectOnOrOffState extends State<SelectOnOrOff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: widgetHeight(100)),
                    Text("어디서 쇼핑하시나요?", style: AppThemes.textTheme.headline1.copyWith(color: Color.fromRGBO(75, 75, 75, 1.0),
                    fontSize: 26)),
                    SizedBox(height: widgetHeight(60)),
                    _selectButton("온라인","startup"),
                    SizedBox(height: widgetHeight(60)),
                    _selectButton("오프라인","store"),
                  ])
          ),
        ),
      );
  }

  Widget _selectButton(String selectText,
      String imageName) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.push(context,MaterialPageRoute(builder:(c) => (selectText == "온라인") ? MainPage() : ProductScanner())),
      child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 90, // 바깥원 반지름
                backgroundColor: AppThemes.mainColor,
                child: CircleAvatar(
                  radius: 85, // 안쪽원 반지름
                  child: Center(child:
                    SizedBox(
                    width: 80,
                    height: 80,
                    child:Image.asset('assets/images/select_page/$imageName.png'),
                  )),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: widgetHeight(15)),
              Text(selectText,
                style: AppThemes.textTheme.headline2.copyWith(color: Color.fromRGBO(75, 75, 75, 1.0)),),
            ]
        )
    );
  }


}