import 'dart:math';

import 'package:buildadroid/StateManagement/FeatureProviders/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final order$ = Provider.of<OrdersItem>(context, listen: false); 
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10
      ),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${order$.amount.toStringAsFixed(2)}'),
          subtitle: Text(order$.dateTime.toString()),
          trailing: Consumer<Orders>(builder : (_, order, __)=> IconButton(icon: Icon( (order.expanded$) ? Icons.expand_more :Icons.expand_less), onPressed: order.togglexpanded
        ))),

            Consumer<Orders>(
              builder: (_, order, __)=> (order.expanded$)? AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min( order$.cartItem.length * 20.0 + 10, 100),
                child: ListView(
                  children: order$.cartItem
                      .map(
                        (prod) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${prod.quantity}x \$${prod.price}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                      )
                      .toList(),
                ), duration: Duration(milliseconds: 9000),
              ): Container(),
            )
        ]
      ),
    );
  }
}