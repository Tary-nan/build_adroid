import 'package:buildadroid/TimeNavigation/Pages/Category_meal_screen.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItems({
    @required this.id,
    @required this.title,
    this.color
  });

  @override
  Widget build(BuildContext context) {

    void _handlerSelectCategory(){
      Navigator.pushNamed(context, CategoryMealsScreen.routName, arguments: {'id': id, 'title': title});
    }

    return Builder(
      builder: (context) => LayoutBuilder(
        builder: (context, constrains)=> GestureDetector(
          onTap: _handlerSelectCategory,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(constrains.maxHeight * .09)),
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(.7),
                  color ],
              end: Alignment.topLeft,
              begin: Alignment.bottomRight,
            ),),
            child: Container(
              height: constrains.maxHeight * .15,
              child: FittedBox(child: Text(title)),
            ),
            ),
        ),
      ),
    );
  }
}