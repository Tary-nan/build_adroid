// import 'package:buildadroid/Expenses/FeatureManager/ExpenseManager.dart';
// import 'package:buildadroid/Expenses/FeatureManager/FormManager.dart';
// import 'package:buildadroid/Expenses/Home.dart';
import 'package:buildadroid/StateManagement/main.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/CategoryManager.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/FiltersManager.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/TabsManager.dart';
// import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:buildadroid/TimeNavigation/Pages/Category_meal_screen.dart';
// import 'package:buildadroid/TimeNavigation/Pages/Category_screen.dart';
import 'package:buildadroid/TimeNavigation/Pages/Filters_screen.dart';
import 'package:buildadroid/TimeNavigation/Pages/Meals_detail_screen.dart';
import 'package:buildadroid/TimeNavigation/Pages/tabs_screen.dart';
// import 'package:buildadroid/TimeNavigation/Models/Meals.dart';

// import 'package:buildadroid/FeatureManage/QuizzManager.dart';
// import 'package:buildadroid/FeatureProvider/Counter.dart';
// import 'package:buildadroid/ProviderArchitecture.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sprinkle/Overseer.dart';

// import 'package:buildadroid/SprinkleArchitecture.dart';
import 'package:sprinkle/Provider.dart';

GetIt sl = GetIt.instance;

void main(){
  runApp(MyAppStateManagement());
}
/*
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Provider(
      data: Overseer()
      .register<ManagerQuizz>(()=> ManagerQuizz())
      ,
      child: Container(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: SprikleArchitecture(),

        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Counter())
      ],
      child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: ProviderArchitecture(),

          ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer()
      .register<ExpenseManager>(()=> ExpenseManager())
      .register<FormManager>(()=> FormManager()),
      child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: HomeExpenses(),
          ),
    );
  }
}
I/chatty  ( 7166): uid=10086(com.example.buildadroid) Thread-2 identical 28 lines

*/

class MyApp extends StatelessWidget {


  
  @override
  Widget build(BuildContext context) {


    return Provider(
      data: Overseer()
      .register<CategoryManager>(()=> CategoryManager())
      .register<TabsManager>(()=> TabsManager())
      .register<FiltersManager>(()=> FiltersManager())
      .register<MealsManager>(()=> MealsManager()),
      child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/' : (context) => TabsScreen(),
              CategoryMealsScreen.routName : (context) => CategoryMealsScreen(),
              MealDeailScreen.routeName : (context) => MealDeailScreen(),
              FiltersScreen.routeName : (context) => FiltersScreen(),
            },
          ),
    );
  }
}