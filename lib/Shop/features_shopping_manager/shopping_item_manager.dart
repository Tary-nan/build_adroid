import 'package:buildadroid/Shop/features_shopping_manager/model_shopping.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprinkle/Manager.dart';

class ShoppingItemManager  implements Manager{

  // Stream to notify if the ShoppingItemWidget is part of the shopping cart
  BehaviorSubject<bool> _isInShoppingCartController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingBasket => _isInShoppingCartController;

  // Stream that receives the list of all items, part of the shopping cart
  PublishSubject<List<ShoppingItem>> _shoppingCartController = PublishSubject<List<ShoppingItem>>();
  Function(List<ShoppingItem>) get shoppingBasket => _shoppingCartController.sink.add;
  
  ShoppingItemManager(ShoppingItem shoppingItem){
    
    _shoppingCartController.stream
      .map((list)=> list.any((item)=> item.id == shoppingItem.id))
        .listen((isShoppingCart) => 
          _isInShoppingCartController.sink.add(isShoppingCart));
  }

  @override
  void dispose() {
    // TO: implement dispose
    _isInShoppingCartController?.close();
    _shoppingCartController?.close();
  }
}