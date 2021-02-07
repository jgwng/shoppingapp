import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/qr_code_scanner/scanner.dart';

class QRCodeScan extends StatefulWidget{
  @override
  _QRCodeScanState createState() => _QRCodeScanState();
}

class _QRCodeScanState extends State<QRCodeScan>{
  var _result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Qr Code Scanner'),),
      body: Center(
        child: Text(_result != null ? _result.toString() : 'Data',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:20,
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.center_focus_strong),
        onPressed: () => _openScanner(context)
      ),
    );
  }


  Future _openScanner(BuildContext context) async{
    final result = await Navigator.push(context,MaterialPageRoute(builder: (c) => Scanner()));
    print(result);
    setState(() {
      _result = result;
    });

  }





}