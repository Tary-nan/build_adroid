import 'package:buildadroid/TimeNavigation/FeatureManager/MealsManager.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class FiltersScreen extends StatelessWidget {

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

  static const routeName = '/filters';
  @override
  Widget build(BuildContext context) {
    MealsManager manager = context.fetch<MealsManager>();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Observer<bool>(
            stream: manager.isSaved,
            onSuccess: (context, bool value) {
              return IconButton(icon: Icon(Icons.save), onPressed: manager.submit);
            }
          )
        ],
      ),
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
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          Container(child: Text("select meals"),),
          Flexible(child:Container(
            height: MediaQuery.of(context).size.height * .5,
            child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

            Observer<bool>(
              stream: manager.gluentenFree$,
              onSuccess: (context, bool value) {
                return _buildSwitchListTile(title: "gluentenFree", desc: "take only lactoose", value: value, onChange: manager.setGluenFree);
              }
            ),
            Observer<bool>(
              stream: manager.vegan$,
              onSuccess: (context, bool value) {
                return _buildSwitchListTile(title: "Vegan", desc: "take only lactoose", value: value, onChange: manager.setVegan);
              }
            ),
            Observer<bool>(
              stream: manager.vegetarian$,
              onSuccess: (context, bool value) {
                return _buildSwitchListTile(title: "Vegetarian", desc: "take only lactoose", value: value, onChange: manager.setVegetarian);
              }
            ),
            Observer<bool>(
              stream: manager.lactooseFree$,
              onSuccess: (context, bool value) {
                return _buildSwitchListTile(title: "lactoose", desc: "take only lactoose", value: value, onChange: manager.setLactooseFree);
              }
            ),
          ],),))
        ],)
      ),
      
    );
  }

  SwitchListTile _buildSwitchListTile({String title, String desc, bool value, Function onChange}) => SwitchListTile(title: Text(title, ), onChanged: onChange, value: value, subtitle: Text(desc),);
}