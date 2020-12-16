import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/products_grid.dart';


class ProductsOverViewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('MyShop'),),
      body: ProductsGrid(),
    );
  }








}