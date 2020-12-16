import 'package:flutter/material.dart';
import 'package:shoppingapp/screens/product_detail_screen.dart';
import 'package:shoppingapp/screens/products_overview_screen.dart';
import './providers/product_provider.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',

        ),
        home: ProductsOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx)=>ProductDetailScreen(),
        },
      ),
    );
  }
}

