
import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';

class OrdersItem {

  final String id;
  final List<CartItem> cartItem;
  final double amount;
  final DateTime dateTime;

  OrdersItem({
    @required this.id, 
    @required this.cartItem, 
    @required this.amount, 
    @required this.dateTime});
}

class OrdersManager implements Manager {

  List<OrdersItem> _orders = [];

  BehaviorSubject<List<OrdersItem>> _order = BehaviorSubject<List<OrdersItem>>.seeded([]);
  Stream<List<OrdersItem>> get orders$ => _order.stream;

  bool _expanded = false;
  bool get expanded$ => _expanded;

  void togglexpanded(){
    _expanded = !_expanded;
    _notify();
  }

  void addOrder({List<CartItem> carts, double amount}){

    List<CartItem> newCartItem = [];

    for (var i = 0; i < carts.length; i++) {
      if (carts[i].quantity <= 0) {
        continue;
      }
      newCartItem.add(
        CartItem(
          id: carts[i].id, 
          title: carts[i].title, 
          quantity: carts[i].quantity, 
          price: carts[i].price));
    }

      _orders.insert(0, OrdersItem(
        id: DateTime.now().toString(),
        cartItem: newCartItem, 
        amount: amount, 
        dateTime: DateTime.now() 
        )
      );
      _notify();
  }

   void _notify(){
     _order.sink.add(_orders);
  }

  @override
  void dispose() {
    _order.close();
  }
  
}