import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:buildadroid/TimeNavigation/Pages/Meals_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';


class MealsItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function removeMeals;

  MealsItem({this.title, this.imageUrl, this.removeMeals, this.duration, this.id, this.affordability, this.complexity});


  String get _affordabilityText{

    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      default:
        return "Unknow";
    }
  }


  @override
  Widget build(BuildContext context) {

    MealsManager manager = context.fetch<MealsManager>();
    manager.setComplixity(complexity);

    _handlerSelectedMeal(){
      Navigator.pushNamed(context, MealDeailScreen.routeName, arguments: id).then((result){
        if(result != null){
          //removeMeals(result);
        }
      });
    }

    return Builder(
      builder: (context)=> GestureDetector(
        onTap: _handlerSelectedMeal,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  child: Image.asset("images/icons8-reconnaissance-faciale-100.png", height: MediaQuery.of(context).size.height * .3, width: MediaQuery.of(context).size.width,),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    color: Colors.white54,
                    width: MediaQuery.of(context).size.width * .6,
                    child: Text(title)),
                )
              ],),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(width:6),
                        Text("$duration mn")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(width:5),
                        Observer<String>(
                          stream: manager.complexityText$,
                          onSuccess: (context, complexityText) {
                            return Text(complexityText);
                          }
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(width:5),
                        Text(_affordabilityText)
                      ],
                    ),
                  ],
                ),
              )
            ]
          ),
          
        ),
      ),
    );
  }
}