import 'package:buildadroid/ReaciveProgramming/blocs/bloc_auth_bloc.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_auth_event.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_auth_state.dart';
import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ReaciveProgramming/screens/bloc_auth_screen.dart';
import 'package:buildadroid/ReaciveProgramming/screens/home_screen.dart';
import 'package:buildadroid/ReaciveProgramming/screens/initializationPage.dart';
import 'package:flutter/material.dart';

// import 'auth_screen.dart';

class DecisionPage extends StatefulWidget {
  static const routeName = '/decision';
  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: BlocEventStateBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state != oldAuthenticationState){
            oldAuthenticationState = state;

            if (state.isAuthenticated){
              _redirectToPage(context, HomePage());
            } else if (state.isAuthenticating || state.hasFailed){
  //do nothing
            } else {
              _redirectToPage(context, AuthenticationPage());
            }
          }
          // This page does not need to display anything since it will
          // always remind behind any active page (and thus 'hidden').
          return Container();
        }
      ),
    );
  }

  void _redirectToPage(BuildContext context, Widget page){
    WidgetsBinding.instance.addPostFrameCallback((_){
      MaterialPageRoute newRoute = MaterialPageRoute(
          builder: (BuildContext context) => page
        );

      Navigator.of(context).pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}