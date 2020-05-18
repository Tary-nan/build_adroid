import 'package:buildadroid/ReaciveProgramming/blocs/bloc_example.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_singleton.dart';
import 'package:buildadroid/ReaciveProgramming/screens/initializationPage.dart';
import 'package:flutter/material.dart';


class ReactiveProgramming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocExample>(
      blocBuilder: ()=> BlocExample(),
      blocDispose: (BlocExample dispose)=> dispose.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InitializationPage(),
      ),
    );
  }
}

