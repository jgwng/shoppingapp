import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/products_grid.dart';

enum FilterOptions{
  Favorites,all
}

class ProductsOverViewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(icon: Icon(Icons.more_vert),
            onSelected: (int selectedValue){
            print(selectedValue);
            },
            itemBuilder: (_) => [
            PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites,),
            PopupMenuItem(child: Text('Show All'), value: FilterOptions.all,)
          ],)
        ],),
      body: ProductsGrid(),
    );
  }








}