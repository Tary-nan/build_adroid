import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Screens/edit_product_screen.dart';
import 'package:buildadroid/StateManagement/Widgets/app_drawer.dart';
import 'package:buildadroid/StateManagement/Widgets/list_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductScreen extends StatelessWidget {

  static const routeName = '/list-product';
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title:Text('list of product'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: ()=> Navigator.pushNamed(context, EditProductScreen.routeName)),
      ],
    ),
    body : ListView.builder(
      itemCount: product.items.length,
      itemBuilder: (context, index)=> ChangeNotifierProvider.value(
        child: ListProductItem(),
        value: product.items[index], )
      ),
    );
  }
}