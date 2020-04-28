import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final manager = Provider.of<Products>(context, listen: false);
    Product productDetail = manager.findById(id: productId);

    return Scaffold(
      appBar: AppBar(title: Text(productDetail.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                //alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset(productDetail.imageUrl, fit: BoxFit.cover,),
                )
                ),
            Flexible(child: 
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 3,
              alignment: Alignment.center,
              child: 
              Column(
                children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Flexible(child: Text(productDetail.title , style: TextStyle(fontWeight: FontWeight.bold),)),
                SizedBox(width:24),
                Flexible(flex:2,child: Container(child: Text('${productDetail.description}', softWrap: true,))),
              ],)
            ],),))

        ]
      ),),
      
    );
  }
}