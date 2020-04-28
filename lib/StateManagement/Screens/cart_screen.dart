import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
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
                    Consumer<Cart>(builder: (_, cartItems, __)=> Chip(label: Text(cartItems.totalAmount.toString(), style: TextStyle(color: Colors.white),),backgroundColor: Theme.of(context).primaryColor,),),
                    FlatButton(onPressed: (){}, child: Text("ORDER NOW",), textColor: Theme.of(context).primaryColor,),
                  ],)
          ]),
            ),)
        ],)
      ),
      
    );
  }
}