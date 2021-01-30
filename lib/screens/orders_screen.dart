import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget{
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context){
    final orderList = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderList.orders.length,
        itemBuilder: (ctx,i) => OrderItem(orderList.orders[i]),),
    );
  }
}

