import 'dart:async';

import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/model_shopping.dart';
import 'package:buildadroid/Shop/features_shopping_manager/shopping_item_manager.dart';
import 'package:buildadroid/Shop/features_shopping_manager/shopping_manager.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class ShoppingItemWidget extends StatefulWidget {
  final ShoppingItem item ;

  ShoppingItemWidget({this.item});

  @override
  _ShoppingItemWidgetState createState() => _ShoppingItemWidgetState();
}

class _ShoppingItemWidgetState extends State<ShoppingItemWidget> {

  ShoppingItemManager _shoppingItemManager;
  StreamSubscription _subscription;
  ShoppingManager _manager;
  CartManager _cart;

  @override
  void didChangeDependencies() {
    // TO: implement didChangeDependencies
    super.didChangeDependencies();
    initManager();
  }

  @override
  void dispose() {
    // TO: implement dispose
    super.dispose();
    _disposeManager();
  }

  @override
  void didUpdateWidget(ShoppingItemWidget oldWidget) {
    // TO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _disposeManager();
    initManager();
  }

  void _disposeManager() {
    _subscription?.cancel();
    _shoppingItemManager?.dispose();
  }

  void initManager(){
    _shoppingItemManager = ShoppingItemManager(widget.item);
    _manager = context.fetch<ShoppingManager>();
    _cart = context.fetch<CartManager>();
    _subscription = _manager.shoppingCart$.listen(_shoppingItemManager.shoppingBasket);
  }

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Container(alignment: Alignment.center, color: widget.item.color, child: Text('\$${widget.item.price}', )),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: StreamBuilder<bool>(
            stream: _shoppingItemManager.isInShoppingBasket,
            initialData: false,
            builder: (context, AsyncSnapshot<bool> isInShoppingBasket) {
              return isInShoppingBasket.data 
              ? IconButton(icon: Icon(Icons.favorite_border), onPressed: ()=> _manager.removeFromShoppingCart(widget.item) , color: Theme.of(context).accentColor,)
              : IconButton(icon: Icon(Icons.favorite_border), onPressed: ()=> _manager.addToShoppingCart(widget.item), color: Theme.of(context).errorColor,);
            }

          ),
          title: Container(
            child: Text(widget.item.title, textAlign: TextAlign.center)
          ),
          trailing:IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('add item to the cart'),
              action: SnackBarAction(label: 'retour', onPressed: (){
                _cart.removeSingleItem(productId: widget.item.id.toString());
              }),
              duration: Duration(seconds: 2),
            ));
            _cart.addCartItem(productId: widget.item.id.toString(), title: widget.item.title, price: widget.item.price);
          }, color: Theme.of(context).accentColor,)),
        ),
    );
  }
}