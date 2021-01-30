import 'package:flutter/cupertino.dart';
import 'package:shoppingapp/providers/product_provider.dart';
import 'package:shoppingapp/widgets/product_item.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/models/product.dart';

class ProductsGrid extends StatelessWidget{
final bool showFavs;
  ProductsGrid(this.showFavs);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
        value: products[i],
        child:  ProductItem(
//          products[i].id,
//          products[i].title,
//          products[i].imageUrl
      ),),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10),
    );
  }

}