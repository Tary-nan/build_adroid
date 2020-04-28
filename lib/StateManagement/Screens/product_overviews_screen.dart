import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Screens/cart_screen.dart';
import 'package:buildadroid/StateManagement/Widgets/badge.dart';
import 'package:buildadroid/StateManagement/Widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOption{
  Favorites,
  All
}
class ProductOverviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final manager = Provider.of<Products>(context,);
    final cart = Provider.of<Cart>(context, listen: false);

    return  Scaffold(
      appBar: AppBar(
        title:Text('Products Overviews'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption valueSelected){
              if(valueSelected == FilterOption.All){
                manager.showAll();
              }else{
                manager.showFavoriteOnly();
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context)=> [
            PopupMenuItem(child: Text("Only Favorites"), value: FilterOption.Favorites,),
            PopupMenuItem(child: Text("Show All"), value: FilterOption.All,)
          ]),
          Consumer<Cart>(builder: (_, cartData, __)=> Badge(child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            Navigator.pushNamed(context, CartScreen.routeName);
          },), value: cartData.itemsCount.toString()))
        ],
      ),
      body: ProductsGrid(),
    );
  }
}