import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/shopping_manager.dart';
import 'package:buildadroid/Shop/widgets/app_drawer.dart';
import 'package:buildadroid/Shop/widgets/shopping_grid.dart';
import 'package:buildadroid/StateManagement/Widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

import 'cart_screen.dart';

class ShoppingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final manager = context.fetch<ShoppingManager>();
    final cartLength = context.fetch<CartManager>();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('overviews product'),
        actions: <Widget>[
          Observer<double>(
            stream: manager.amount$,
            onSuccess: (context, double price) {
              return Text(price.toString());
            }
          ),
          Observer<int>(
            stream: cartLength.count$,
            onWaiting: (context)=> Badge(child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: ()=> showDialog(context:context, builder: (context)=> AlertDialog(
              title: Text("Aucun produit n'est ajouter"),
              content: Text("veuiller ajouter des produits au panier?"),
              actions: <Widget>[
                // FlatButton(onPressed: ()=> Navigator.of(context).pop(false) , child: Text('No!')),
                FlatButton(onPressed: ()=> Navigator.of(context).pop(true) , child: Text('Yes!')),
              ],
              )),), value: '0'),
            onSuccess: (context, int itemCount) {
              return Badge(
                child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                Navigator.pushNamed(context, CartScreen.routeName);
              },), value: itemCount.toString());
            }
          )
        ],
      ),
      body: ShoppingGrid(),
    );
  }
}