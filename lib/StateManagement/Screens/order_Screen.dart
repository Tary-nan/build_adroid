import 'package:buildadroid/StateManagement/FeatureProviders/orders.dart';
import 'package:buildadroid/StateManagement/Widgets/app_drawer.dart';
import 'package:buildadroid/StateManagement/Widgets/order_item.dart' show OrderItem;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {

    final command = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: command.orders.length,
        itemBuilder: (context, index)=> ChangeNotifierProvider.value(
          value: command.orders[index],
          child: OrderItem())),

      
    );
  }
}