import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/order_manager.dart';
import 'package:buildadroid/Shop/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';


class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {

    final cart = context.fetch<CartManager>();
    final order = context.fetch<OrdersManager>();

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
                    Chip(label: Observer<double>(
                      stream: cart.amount$,
                      onWaiting: (context)=> Text('\$0.0'),
                      onSuccess: (context, double priceTotal) {
                        return Text("\$${priceTotal.toStringAsFixed(2)}", style: TextStyle(color: Colors.white),);
                      }
                    ),backgroundColor: Theme.of(context).primaryColor,),
                    Observer<List<CartItem>>(
                      stream: cart.shoppingCart$,
                      onSuccess: (context, List<CartItem> carts) {
                        return FlatButton(onPressed: (){
                          order.addOrder(carts: carts, amount: cart.totalAmount);
                          cart.clear();
                        }, child: Text("ORDER NOW", style: TextStyle(fontSize:13)), textColor: Theme.of(context).primaryColor,);
                      }
                    ),
                  ],)
          ]),
            ),),

            Flexible(child: Container(
              child: Observer<Map<String, CartItem>>(
              stream: cart.shop$,
              onSuccess: (context, Map<String, CartItem> carts) {
                return ListView.builder(
                  itemBuilder: (context, index)=> CartItemWidget(carts.values.toList()[index], carts.keys.toList()[index] ),
                  itemCount: carts.length,
                  );
              }
            ),))
        ],)
      ),
      
    );
  }
}