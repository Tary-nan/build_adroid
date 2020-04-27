import 'package:flutter/material.dart';

class MyAppStateManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My boutic shop",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("My shop")),
        body: Center(child:Text("Let's build a shop ")),
        
      ),
    );
  }
}