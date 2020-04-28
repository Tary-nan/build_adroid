import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:buildadroid/StateManagement/Screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class  ProductsItem extends StatelessWidget {
  // ProductsItem({this.id, this.title, this.imageUrl});
  // final String id;
  // final String title;
  // final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    void _hanlerDetailPage(){
      Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product.id);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: _hanlerDetailPage,
          child: Container(
            child: Image.asset(product.imageUrl, fit: BoxFit.cover,),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (BuildContext context, product, Widget _) => IconButton(icon: Icon( (product.isfavorite)? Icons.favorite : Icons.favorite_border), onPressed: product.toggleFavoriteStatus , color: Theme.of(context).accentColor,),),
          title: Container(
            child: Text(product.title, textAlign: TextAlign.center)
          ),
          trailing: Consumer<Cart>(builder: (_, cartData, __)=> IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
            cart.addCartItem(productId: product.id, title: product.title, price: product.price);
          }, color: Theme.of(context).accentColor,)),
        ),
      ),
    );
  }
}