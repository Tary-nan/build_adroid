import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartsItem extends StatelessWidget {

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartsItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context, listen: false).removeItem(productId);
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
              child: Text('\$$price'),
            ),),
          ),
          title: Text( title),
          subtitle: Text("total : \$${price * quantity} prix"),
          trailing: Text("$quantity x"),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),
        
      ),
    );
  }
}