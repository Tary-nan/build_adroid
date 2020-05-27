import 'package:buildadroid/Shop/features_shopping_manager/model_shopping.dart';
import 'package:buildadroid/Shop/features_shopping_manager/shopping_manager.dart';
import 'package:buildadroid/Shop/widgets/shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class ShoppingGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final manager = context.fetch<ShoppingManager>();
    
    return Observer<List<ShoppingItem>>(
          stream: manager.collection$,
          onSuccess: (context,List<ShoppingItem> items) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context, index)=> ShoppingItemWidget(item: items[index],),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3/2
                ),
            );
          }
    );
  }
}