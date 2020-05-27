import 'dart:math';
import 'package:rxdart/rxdart.dart';

import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:flutter/material.dart';

class ShoppingBloc implements BlocBase {
  // List of all items, part of the shopping basket
  Set<ShoppingItem> _shoppingBasket = Set<ShoppingItem>();

  // Stream to list of all possible items
  BehaviorSubject<List<ShoppingItem>> _itemsController = BehaviorSubject<List<ShoppingItem>>();
  Stream<List<ShoppingItem>> get items => _itemsController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<ShoppingItem>> _shoppingBasketController = BehaviorSubject<List<ShoppingItem>>.seeded(<ShoppingItem>[]);
  Stream<List<ShoppingItem>> get shoppingBasket => _shoppingBasketController;

  @override
  void dispose() {
    _itemsController?.close();
    _shoppingBasketController?.close();
  }

  // Constructor
  ShoppingBloc() {
    _loadShoppingItems();
  }

  void addToShoppingBasket(ShoppingItem item){    
    _shoppingBasket.add(item);
    _postActionOnBasket();
  }

  void removeFromShoppingBasket(ShoppingItem item){
    _shoppingBasket.remove(item);
    _postActionOnBasket();
  }

  void _postActionOnBasket(){
    // Feed the shopping basket stream with the new content
    _shoppingBasketController.sink.add(_shoppingBasket.toList());
    
    // any additional processing such as
    // computation of the total price of the basket
    // number of items, part of the basket...
  }

  //
  // Generates a series of Shopping Items
  // Normally this should come from a call to the server
  // but for this sample, we simply simulate
  //
  void _loadShoppingItems() {
    _itemsController.sink.add(List<ShoppingItem>.generate(3, (int index) {
      return ShoppingItem(
        id: index,
        title: "Item $index",
        price: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() /
            100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(1.0),
      );
    }));
  }
}

class ShoppingItem {

  ShoppingItem({this.id, this.title, this.price, this.color});

  final int id;
  final String title;
  final double price;
  final Color color;
  
}