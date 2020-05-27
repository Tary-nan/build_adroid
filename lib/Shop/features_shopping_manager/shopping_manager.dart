import 'dart:math';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';


import 'package:buildadroid/Shop/features_shopping_manager/model_shopping.dart';
import 'package:sprinkle/Manager.dart';

class ShoppingManager implements Manager {

  Set<ShoppingItem> _shoppingCart = Set<ShoppingItem>();

  // stream displaying collection article
  BehaviorSubject<List<ShoppingItem>> _collectionSubject = BehaviorSubject<List<ShoppingItem>>();
  Stream<List<ShoppingItem>> get collection$ => _collectionSubject.stream;

  // stream displaying collection article
  BehaviorSubject<List<ShoppingItem>> _shoppingListCart = BehaviorSubject<List<ShoppingItem>>();
  Stream<List<ShoppingItem>> get shoppingCart$ => _shoppingListCart.stream;

   // stream displaying counter cart
  BehaviorSubject<int> _count = BehaviorSubject<int>();
  Stream<int> get count$ => _count.stream;

  PublishSubject<double> _amount = PublishSubject<double>();
  Stream<double> get amount$ => _amount.stream;

  void _notify(){
    // notify list of shoppingCart
    _shoppingListCart.sink.add(_shoppingCart.toList());
    //count element in shoppingCart
    _count.sink.add(_shoppingCart.length);
  }

  void addToShoppingCart(ShoppingItem item){
    _shoppingCart.add(item);
    _notify();
  }

  void removeFromShoppingCart(ShoppingItem item){
    _shoppingCart.remove(item);
    _notify();
  }

  ShoppingManager(){
    _collectionSubject.sink.add(List<ShoppingItem>.generate(3, (int index){
      var title = ['books', 'mobile phone', 'savon'];
      return ShoppingItem(
        id: index,
        title: title[index],
        price: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() / 100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
      );
    }));
  }

  @override
  void dispose() {
    // TO implement dispose
    _collectionSubject?.close();
    _shoppingListCart?.close();
    _count?.close();
    _amount?.close();
  }
}