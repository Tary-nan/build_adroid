import 'package:buildadroid/FeatureProvider/Counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderArchitecture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Counter manager = Provider.of<Counter>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(),
      body: Center(child:Center(child: Text(manager.count$.toString()))),
      floatingActionButton: FloatingActionButton(onPressed: ()=> manager.increment()),
      
    );
  }
}