import 'package:flutter/foundation.dart';

class CartItem  with ChangeNotifier{
  CartItem({this.id, this.title, this.quantity, this.price});

  final String id;
  final String title;
  final int quantity;
  final double price;
  
}

class Cart with ChangeNotifier {

  Map<String, CartItem> _items = {};
  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem){
        total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Map<String, CartItem> get items => {..._items};

  void removeSingleItem({String productId}){

    if(!_items.containsKey(productId)){
      print('this item dont\' exist');
      return;
    }
    if(_items[productId].quantity > 1){
      print(_items[productId].quantity > 1);
      _items.update(productId, (existingCardItem)=> CartItem(id: existingCardItem.id, title: existingCardItem.title, price: existingCardItem.price, quantity: existingCardItem.quantity -1));
    }else{
      print("remove when ${_items[productId].quantity > 1} == false");
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addCartItem({String productId, String title, double price}){

    final bool existingKey = _items.containsKey(productId);
    if(existingKey){
      // .... change quantity
      _items.update(productId, (existingCartItem)=> CartItem(id: existingCartItem.id, title: existingCartItem.title, price: existingCartItem.price, quantity: existingCartItem.quantity + 1));
    }else{
      ///.... put in items
      _items.putIfAbsent(productId, ()=> CartItem(id: DateTime.now().toString(), title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
  
}