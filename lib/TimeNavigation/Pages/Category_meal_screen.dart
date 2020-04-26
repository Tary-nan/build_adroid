

import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:buildadroid/TimeNavigation/Widgets/MealsItems.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routName = '/category-meal-screen';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    String _title = routeArgs['title'];
    String _id = routeArgs['id'];

    MealsManager manager = context.fetch<MealsManager>();
    manager.searchListItem(id:_id);

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Builder(builder: (context)=> LayoutBuilder(
        builder: (context, constraints)=> Observer(
          stream: manager.collection$,
          onSuccess: (context,List<Meal> data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index)=> MealsItem(
              id: data[index].id,
              title: data[index].title,
              imageUrl: data[index].imageUrl,
              complexity: data[index].complexity,
              affordability: data[index].affordability,
              duration: data[index].duration,
              removeMeals: manager.removeMeal,
              ) 
            ),
            onError: (context, error)=> Center(child:Text(error)),
        )
      )),
    );
  }
}