import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/src/qr_scanner_overlay_shape.dart';
class Scanner extends StatefulWidget{
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner>{

  bool _flashOn = false;
  bool _frontCam = false;
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
                  _controller.dispose();
                  Navigator.pop(context,val);
                }
              });
            },

          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top:60),
             child: Text('Scanner',style:TextStyle(
               fontSize: 18,fontWeight: FontWeight.bold,color:Colors.white)
             )),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                  IconButton(
                    color:Colors.white,
                    icon:Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                    onPressed: (){
                      setState(() {
                        _flashOn = !_flashOn;
                      });
                      _controller.toggleFlash();
                    },
                  ),
                  IconButton(
                    color:Colors.white,
                    icon:Icon(_frontCam ? Icons.camera_front : Icons.camera_rear),
                    onPressed: (){
                      setState(() {
                        _frontCam = !_frontCam;
                      });
                      _controller.flipCamera();
                    },
                  ),
                  IconButton(
                    color:Colors.white,
                    icon:Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
            ),
          )
        ],
      )
    );
  }

}