import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:buildadroid/StateManagement/Widgets/products_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  // final bool showFvs;

  // ProductsGrid(this.showFvs);

  @override
  Widget build(BuildContext context) {

  final manager = Provider.of<Products>(context);
  List<Product> products = manager.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index)=> ChangeNotifierProvider.value(
        // create: (context)=> products[index],
        value: products[index],
        child: ProductsItem(
          // id: products[index].id,
          // title: products[index].title,
          // imageUrl: products[index].imageUrl,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3/2
        ),
    );
  }
}