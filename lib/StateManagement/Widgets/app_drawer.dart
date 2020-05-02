import 'package:buildadroid/StateManagement/Screens/list_product_screen.dart';
import 'package:buildadroid/StateManagement/Screens/order_Screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Edit product'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ListProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
