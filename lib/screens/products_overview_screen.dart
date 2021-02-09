import 'package:flutter/material.dart';
import 'package:shoppingapp/providers/product_provider.dart';
import 'package:shoppingapp/screens/cart_screen.dart';
import 'package:shoppingapp/widgets/app_drawer.dart';
import 'package:shoppingapp/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

enum FilterOptions{
  Favorites,all
}

class ProductsOverViewScreen extends StatefulWidget{
  @override
  _ProductsOverViewScreenState createState() => _ProductsOverViewScreenState();
}




class _ProductsOverViewScreenState extends State<ProductsOverViewScreen>{
 var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final productsContainer = Provider.of<Products>(context,listen: false);

    return  Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue){
              setState(() {
             if(selectedValue == FilterOptions.Favorites){
               _showOnlyFavorites = true;
             }else{
               _showOnlyFavorites = false;
             }
           });
            },
            itemBuilder: (_) => [
            PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites,),
            PopupMenuItem(child: Text('Show All'), value: FilterOptions.all,)
          ],),
          Consumer<Cart>(builder: (_,cart,child) => Badge(
            child: child,
            value: cart.itemCount.toString()),
            child:  IconButton(
              icon: Icon(Icons.shopping_cart),
            onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);

            },))
        ],),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }








}