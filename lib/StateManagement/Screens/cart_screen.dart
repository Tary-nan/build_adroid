import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart' show Cart;
import 'package:buildadroid/StateManagement/FeatureProviders/orders.dart';
import 'package:buildadroid/StateManagement/Widgets/carts_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your cart"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total', style: TextStyle(fontSize:20),),
                Row(
                  children: <Widget>[
                    Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),),backgroundColor: Theme.of(context).primaryColor,),
                    FlatButton(onPressed: (){
                      Provider.of<Orders>(context, listen: false).addOrder(carts: cart.items.values.toList(), amount: cart.totalAmount);
                      cart.clear();
                    }, child: Text("ORDER NOW", style: TextStyle(fontSize:13)), textColor: Theme.of(context).primaryColor,),
                  ],)
          ]),
            ),),

            Flexible(child: Container(child: ListView.builder(
              itemBuilder: (context, index)=> CartsItem(
                cart.items.values.toList()[index].id, cart.items.keys.toList()[index], cart.items.values.toList()[index].price, cart.items.values.toList()[index].quantity, cart.items.values.toList()[index].title
                ),
              itemCount: cart.itemsCount,
              ),))
        ],)
      ),
      
    );
  }
}