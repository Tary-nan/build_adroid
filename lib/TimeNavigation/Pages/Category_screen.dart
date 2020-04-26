import 'package:buildadroid/TimeNavigation/FeatureManager/CategoryManager.dart';
import 'package:buildadroid/TimeNavigation/Models/Category.dart';
import 'package:buildadroid/TimeNavigation/Widgets/CategoryItems.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    MediaQueryData _mediaQuery =  MediaQuery.of(context); 
    CategoryManager manager = context.fetch<CategoryManager>();
    

    return Scaffold(
      body: Builder(
        builder: (context) => LayoutBuilder(
          builder: (context, constraints) => Observer<List<CategoryModel>>(
            stream: manager.collection$,
            onSuccess: (context,List<CategoryModel> category) {
              return GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _mediaQuery.size.width * .5,
                childAspectRatio: 3/2,
                crossAxisSpacing: constraints.maxHeight * .03,
                mainAxisSpacing: constraints.maxHeight * .03,
                ), 
                itemCount: category.length,
                itemBuilder: (context, index)=> CategoryItems(id: category[index].id, title: category[index].title, color: category[index].color));
            }
          ),
        )
      ),
      
    );
  }
}