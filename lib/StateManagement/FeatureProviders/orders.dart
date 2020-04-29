import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:flutter/foundation.dart';

class OrdersItem with ChangeNotifier {

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

class Orders with ChangeNotifier {

  List<OrdersItem> _orders = [];
  List<OrdersItem> get orders => [..._orders];

  bool _expanded = false;
  bool get expanded$ => _expanded;

  void togglexpanded(){
    _expanded = !_expanded;
    notifyListeners();
  }

  void addOrder({List<CartItem> carts, double amount}){
    _orders.insert(0, OrdersItem(
        id: DateTime.now().toString(),
        cartItem: carts, 
        amount: amount, 
        dateTime: DateTime.now() 
        )
      );
    notifyListeners();
  }
  
}