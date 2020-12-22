import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/product_detail_screen.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';


class ProductItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   final product = Provider.of<Product>(context);


    return ClipRRect(
     borderRadius: BorderRadius.circular(10.0),
     child: GridTile(
         child:
         GestureDetector(
           onTap: (){
             Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
               arguments: product.id,
             );
           },
          child: Image.network(product.imageUrl,fit: BoxFit.cover,)
         ),
          footer: GridTileBar(
             backgroundColor: Colors.black87,
             leading: IconButton(
               icon: Icon(
                   product.isFavorite ? Icons.favorite : Icons.favorite_border),
               color: Theme.of(context).accentColor,
               onPressed: (){
                 product.toggleFavoriteStatus();
               },
             ),
             title: Text(product.title, textAlign: TextAlign.center,),
             trailing : IconButton(
               icon: Icon(Icons.shopping_cart),
               onPressed: (){


               },
               color: Theme.of(context).accentColor,
             )
         )
     ),
   );
  }

}