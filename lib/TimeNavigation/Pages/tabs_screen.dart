import 'package:buildadroid/TimeNavigation/Pages/Filters_screen.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';
import 'package:buildadroid/TimeNavigation/FeatureManager/TabsManager.dart';
import 'package:buildadroid/TimeNavigation/Pages/Category_screen.dart';
import 'package:buildadroid/TimeNavigation/Pages/Favorites_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget{


  final List<Map<String, Object>> _pages = [
    {'page': CategoryScreen(), 'title': "category" },
    {'page': FavoritesScreen(), 'title': "favorites"},
  ];

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    TabsManager manager = context.fetch<TabsManager>();

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child:  Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),

      ),
        bottomNavigationBar: Observer<int>(
          stream: manager.curent$,
          onSuccess: (context, currentIndex$) {
            return BottomNavigationBar(
              onTap: manager.handlerSelectTabs,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black54,
              currentIndex: currentIndex$,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Category")),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), title: Text("Favories")),
              ]
              );
          }
        ),
        body: Observer<int>(
          stream: manager.curent$,
          onSuccess: (context, select) {
            return _pages[select]['page'];
          }
        ),      
    );
  }
}