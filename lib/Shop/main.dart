import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/order_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/shopping_manager.dart';
import 'package:buildadroid/Shop/screens/cart_screen.dart';
import 'package:buildadroid/Shop/screens/order_screen.dart';
import 'package:buildadroid/Shop/screens/shopping_screen.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Overseer.dart';
import 'package:sprinkle/Provider.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer()
      .register<ShoppingManager>(()=> ShoppingManager())
      .register<CartManager>(()=> CartManager())
      .register<OrdersManager>(()=> OrdersManager())
      ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/' : (context)=> ShoppingScreen(),
          CartScreen.routeName : (context)=> CartScreen(),
          OrdersScreen.routeName : (context)=> OrdersScreen(),
        },
      ),
    );
  }
}