import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:buildadroid/TimeNavigation/Widgets/MealsItems.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    MealsManager manager = context.fetch<MealsManager>();

    return Observer<List<Meal>>(
          stream: manager.favoriteList$,
          onSuccess: (context,List<Meal> meals) {
            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index)=> MealsItem(
              id: meals[index].id,
              title: meals[index].title,
              imageUrl: meals[index].imageUrl,
              complexity: meals[index].complexity,
              affordability: meals[index].affordability,
              duration: meals[index].duration,
              ) ,
        );
      }
    );
  }
}