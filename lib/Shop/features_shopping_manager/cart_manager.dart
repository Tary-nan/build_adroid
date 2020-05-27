import 'package:rxdart/rxdart.dart';
import 'package:sprinkle/Manager.dart';

class CartManager  implements Manager{

  Map<String, CartItem> _items = {};

  BehaviorSubject<List<CartItem>> _cart = BehaviorSubject<List<CartItem>>();
  Stream<List<CartItem>> get shoppingCart$ => _cart.stream;

  BehaviorSubject<Map<String, CartItem>> _shop = BehaviorSubject<Map<String, CartItem>>();
  Stream<Map<String, CartItem>> get shop$ => _shop.stream;

  BehaviorSubject<int> _count = BehaviorSubject<int>();
  Stream<int> get count$ => _count.stream;

  BehaviorSubject<double> _amount = BehaviorSubject<double>();
  Stream<double> get amount$ => _amount.stream;

    double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem){
        total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addQuantity(String productId){
    print(productId);
    final bool existingKey = _items.containsKey(productId);
    if(existingKey){
      _items.update(productId, (existingCartItem)=> CartItem(id: existingCartItem.id, title: existingCartItem.title, price: existingCartItem.price, quantity: existingCartItem.quantity + 1));
    }
    _notify();
  }

  void removeQuantity(String productId){
    final bool existingKey = _items.containsKey(productId);
    if(existingKey){
      
      _items.update(productId, (existingCartItem){
        if(existingCartItem.quantity <= 0) {
          return CartItem(id: existingCartItem.id, title: existingCartItem.title, price: existingCartItem.price, quantity: existingCartItem.quantity);
        }
        return CartItem(id: existingCartItem.id, title: existingCartItem.title, price: existingCartItem.price, quantity: existingCartItem.quantity - 1);
      });
    }
    _notify();
  }

  void addCartItem({String productId, String title, double price}){
    final bool existingKey = _items.containsKey(productId);
    if(existingKey){
      _items.update(productId, (existingCartItem)=> CartItem(id: existingCartItem.id, title: existingCartItem.title, price: existingCartItem.price, quantity: existingCartItem.quantity + 1));
    }else{
      _items.putIfAbsent(productId, ()=> CartItem(id: DateTime.now().toString(), title: title, price: price, quantity: 1));
    }
    _notify();
  }  

  void removeSingleItem({String productId}){

    if(!_items.containsKey(productId)) return;

    if(_items[productId].quantity > 1){
      _items.update(productId, (existingCardItem)=> CartItem(id: existingCardItem.id, title: existingCardItem.title, price: existingCardItem.price, quantity: existingCardItem.quantity -1));
    }else{
      _items.remove(productId);
    }
    _notify();
  }
  
  
  void removeCartItem({String productId}){
   _items.remove(productId);
   _notify();
  }

  void clear(){
    _items = {};
    _amount.sink.add(0.0);
    _notify();
  }

  void _notify(){
    _shop.sink.add(_items);
    _cart.sink.add(_items.values.toList());
    _count.sink.add(_items.length);
    _cart.listen((element){
      double total = 0.0;
      element.forEach((item)=> _amount.add(total += item.price * item.quantity));
    });
  }


  @override
  
  void dispose() {
    // TO: implement dispose
    _cart.close();
    _count.close();
    _amount.close();
    _shop.close();
  }
  
}

class CartItem {
  CartItem({this.id, this.title, this.quantity, this.price});

  final String id;
  final String title;
  final int quantity;
  final double price;
  
}