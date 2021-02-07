import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/qr_code_scanner/qr_code_scanner.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';
class ProductDetailScreen extends StatelessWidget{
  final String title;
  final double price;
  ProductDetailScreen({this.title,this.price});
  static const routeName='/product-detail';




  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,listen: false).findById(productId);


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (c) => QRCodeScan()));
              },
              child: Container(
               height: 300, width: double.infinity,
                  child: Image.network(loadedProduct.imageUrl,fit:BoxFit.cover),),
            ),
            SizedBox(height: 10,),
            Text('${loadedProduct.price}',style: TextStyle(color:Colors.grey,fontSize:20),),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(loadedProduct.description,textAlign: TextAlign.center,softWrap: true,)
            )
          ],
        ),
      )





    );
  }

}