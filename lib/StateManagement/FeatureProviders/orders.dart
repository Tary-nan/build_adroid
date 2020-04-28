import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:flutter/foundation.dart';

class OrdersItem with ChangeNotifier {
  OrdersItem({@required this.id, @required this.cartItem, @required this.amount, @required this.dateTime});


  final String id;
  final List<CartItem> cartItem;
  final double amount;
  final DateTime dateTime;
  
}

class Order with ChangeNotifier {

  List<OrdersItem> _orders = [];
  List<OrdersItem> get orders => [..._orders];

  void addOrder({List<CartItem> carts, double amount}){
    _orders.insert(0, OrdersItem(id: DateTime.now().toString(),cartItem: carts, amount: amount, dateTime: DateTime.now() ));
    notifyListeners();
  }
  
}