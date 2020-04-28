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
      
    );
  }
}