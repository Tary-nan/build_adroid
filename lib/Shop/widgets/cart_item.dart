import 'package:buildadroid/Shop/features_shopping_manager/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class CartItemWidget extends StatelessWidget {

  final CartItem item;
  final String index;
  CartItemWidget(this.item, this.index);

  @override
  Widget build(BuildContext context) {
    final cart = context.fetch<CartManager>();

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context:context, builder: (context)=> AlertDialog(
          title: Text("I you sure?"),
          content: Text("do you want to delete this product in your cart?"),
          actions: <Widget>[
            FlatButton(onPressed: ()=> Navigator.of(context).pop(false) , child: Text('No!')),
            FlatButton(onPressed: ()=> Navigator.of(context).pop(true) , child: Text('Yes!')),
          ],
          ));
      },
      onDismissed: (direction){
        cart.removeCartItem(productId: index);
      },
      background: Container(
        padding: EdgeInsets.only(right: 15),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, size: 30, color: Colors.white),
        color: Theme.of(context).errorColor,
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\$${item.price}'),
            ),),
          ),
          title: Text( item.title),
          subtitle: Text("total : \$${(item.price * item.quantity).toStringAsFixed(2)} \$"),
          trailing: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.add, size: 20,),padding: EdgeInsets.all(1.0), onPressed: ()=> cart.addQuantity(index)),
                IconButton(icon: Icon(Icons.equalizer, size: 20,),padding: EdgeInsets.all(1.0), onPressed: ()=> cart.removeQuantity(index)),
                Text("${item.quantity} x"),
              ],
            ),
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),
        
      ),
    );
  }
}