import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class MealDeailScreen extends StatelessWidget {
  static const routeName = '/detail-meals';
  @override
  Widget build(BuildContext context) {

    final id = ModalRoute.of(context).settings.arguments as String;
    MealsManager manager = context.fetch<MealsManager>();
    manager.searchDetailMealById(id: id);

    return Builder(
      builder: (context)=> Observer<Meal>(
        stream: manager.detail$,
        onSuccess: (context, Meal meal) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: ()=> manager.toggleFavorite(mealId: id), 
            child:  Observer<bool>(
              stream: manager.isFavorite$,
              onSuccess: (context, bool favorite) {
                manager.isFavorite(id);
                return (favorite)? Icon(Icons.star, color: Colors.white,) :  Icon(Icons.star_border, color: Colors.white);
              }
            )),
            appBar: AppBar(
              title: Text(meal.title),
            ),
            body: Container(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .25,
                        child: Image.asset("images/face-id.png" )
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                         height: MediaQuery.of(context).size.height * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              Flexible(
                              child: Container(
                                child: FittedBox(child: Text("Ingredient", style: TextStyle(fontWeight: FontWeight.bold),))
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Align(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  height: MediaQuery.of(context).size.height * .31,
                                  width: MediaQuery.of(context).size.height * .5,
                                  child: ListView.builder(
                                    itemCount: meal.ingredients.length,
                                    itemBuilder: (context, index)=> Card(child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10
                                      ),
                                      child: Text( meal.ingredients[index]),
                                    ))
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   Flexible(
                     fit: FlexFit.loose,
                      child: Container(
                         height: MediaQuery.of(context).size.height * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: FittedBox(child: Text("Steps", style: TextStyle(fontWeight: FontWeight.bold),))
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                height: MediaQuery.of(context).size.height * .31,
                                width: MediaQuery.of(context).size.height * .5,
                                child: ListView.builder(
                                  itemCount: meal.steps.length,
                                  itemBuilder: (context, index)=> Card(child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child:Text("#${index + 1}")
                                      ),
                                      title: Text( meal.steps[index])),
                                  ))
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
          );
        }
      ),
    );
  }
}