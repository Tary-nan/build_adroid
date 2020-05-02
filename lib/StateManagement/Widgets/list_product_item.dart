import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:buildadroid/StateManagement/Screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context); 
    final product = Provider.of<Products>(context); 
    return ListTile(
      title: Text(productItem.title),
      subtitle: Text(productItem.description),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(productItem.imageUrl,),
      ),
      trailing: Container(
        width: MediaQuery.of(context).size.width /4,
        child: Row(children: <Widget>[
          IconButton(icon: Icon(Icons.edit, ), onPressed: ()=> Navigator.pushNamed(context, EditProductScreen.routeName),),
          IconButton(icon: Icon(Icons.delete, color: Theme.of(context).errorColor,), onPressed: (){
            Scaffold.of(context).hideCurrentSnackBar();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('delete product'),
              action: SnackBarAction(label: 'retour', onPressed: (){
              }),
              duration: Duration(seconds: 2),
            ));
            product.removeProduct(productItem.id);
          }),
        ],)
      ),
    );
  }
}