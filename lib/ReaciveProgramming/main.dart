import 'package:buildadroid/ReaciveProgramming/blocs/bloc_auth_bloc.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_example.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_singleton.dart';
import 'package:buildadroid/ReaciveProgramming/screens/auth_screen.dart';
import 'package:buildadroid/ReaciveProgramming/screens/bloc_decision_screen.dart';
import 'package:buildadroid/ReaciveProgramming/screens/initializationPage.dart';
import 'package:flutter/material.dart';


class ReactiveProgramming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      blocBuilder: ()=> AuthenticationBloc(),
      blocDispose: (AuthenticationBloc dispose)=> dispose.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DecisionPage(),
        // initialRoute: '/',
        // routes: {
        //   '/' : (context) => DecisionPage(),
        //   DecisionPage.routeName : (context) => DecisionPage(),
        //   AuthenticationScreen.routeName : (context) => AuthenticationScreen(),
        // },
      ),
    );
  }
}

