import 'package:buildadroid/Shop/features_shopping_manager/order_manager.dart';
import 'package:buildadroid/Shop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = context.fetch<OrdersManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: Observer<List<OrdersItem>>(
        stream: orders.orders$,
        onSuccess: (context, List<OrdersItem> cmd) {
          return cmd.length == 0 
          ? Center(child: Text('Aucune commande effectuer')) 
          :ListView.builder(
            itemCount: cmd.length,
            itemBuilder: (context, index)=> Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: cmd[index].cartItem.map((element)=> Text(element.title)).toList(),
              ),
            ));
        }
      ),   
    );
  }
}