import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ShoppingCartBloc/bloc/bloc_shopping_bloc.dart';
import 'package:buildadroid/ShoppingCartBloc/bloc/bloc_shopping_page.dart';
import 'package:flutter/material.dart';

class MyShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        home: ShoppingPage(),
        
        debugShowCheckedModeBanner: false,
      ), blocBuilder: ()=> ShoppingBloc(),
    );
  }
}