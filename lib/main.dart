import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/landing_page.dart';
import 'package:shoppingapp/providers/cart.dart';
import 'package:shoppingapp/providers/orders.dart';
import 'package:shoppingapp/screens/cart_screen.dart';
import 'package:shoppingapp/screens/product_detail_screen.dart';
import 'package:shoppingapp/screens/products_overview_screen.dart';
import 'package:shoppingapp/screens/register_page/user_register_page.dart';
import './providers/product_provider.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import 'package:shoppingapp/screens/orders_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ProviderScope(
      child : MyApp()
    ));
  });

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',

        ),

        home: LandingPage(),
        routes: {
          ProductDetailScreen.routeName: (ctx)=>ProductDetailScreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
          OrdersScreen.routeName:(ctx)=> OrdersScreen(),
        },
      );
  }
}

