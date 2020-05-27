import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ShoppingCartBloc/bloc/bloc_shopping_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingItemBloc implements BlocBase {
  // Stream to notify if the ShoppingItemWidget is part of the shopping basket
  BehaviorSubject<bool> _isInShoppingBasketController = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isInShoppingBasket => _isInShoppingBasketController.stream;

  // Stream that receives the list of all items, part of the shopping basket
  PublishSubject<List<ShoppingItem>> _shoppingBasketController = PublishSubject<List<ShoppingItem>>();
  Function(List<ShoppingItem>) get shoppingBasket => _shoppingBasketController.sink.add;

  // Constructor with the 'identity' of the shoppingItem
  ShoppingItemBloc(ShoppingItem shoppingItem){
    // Each time a variation of the content of the shopping basket
    _shoppingBasketController.stream
                          // we check if this shoppingItem is part of the shopping basket
        .map((list) => list.any((ShoppingItem item) => item.id == shoppingItem.id))
        // if it is part
        .listen((isInShoppingBasket)
            // we notify the ShoppingItemWidget 
          => _isInShoppingBasketController.add(isInShoppingBasket));
  }

  @override
  void dispose() {
    _isInShoppingBasketController?.close();
    _shoppingBasketController?.close();
  }
}