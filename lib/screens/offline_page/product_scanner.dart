import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shoppingapp/constants/app_themes.dart';
import 'package:shoppingapp/screens/offline_page/offline_cart_page.dart';

class ProductScanner extends StatefulWidget{
  @override
  _ProductScannerState createState() => _ProductScannerState();
}

class _ProductScannerState extends State<ProductScanner>{
  int scanProduct = 0;
  GlobalKey _qrKey = GlobalKey();
  QRViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :Stack(
        children: [
          QRView(
            key:_qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white
            ),
            onQRViewCreated: (QRViewController controller){
              this._controller = controller;
              controller.scannedDataStream.listen((val){
                print("val : ${val.code}");
                if(mounted){
                 if(val != null)
                  setState(() {
                   scanProduct +=1;
                 });
                }
              });
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top:60),
             child: Text('제품 스캔',style: AppThemes.textTheme.subtitle1.copyWith(
                 fontWeight: FontWeight.bold,color:Colors.white
             )
            ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                if(mounted && scanProduct != 0){
                  _controller.dispose();
                  Navigator.push(context,MaterialPageRoute(builder:(c) => OfflineCartPage(productCount : scanProduct)));
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 24,right: 24,bottom: 30,top:10),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppThemes.mainColor,
                    borderRadius: BorderRadius.circular(6.0)
                ),
                child: Text('${scanProduct==0 ? '' : '총 $scanProduct개'} 제품 구매',style:AppThemes.textTheme.headline1.copyWith(fontSize: 20,color: Colors.white),
                  textAlign: TextAlign.center,),
              ),
            ),
          )
        ],
      )
    );
  }

}