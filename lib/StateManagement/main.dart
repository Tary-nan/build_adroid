import 'package:buildadroid/StateManagement/FeatureProviders/cart.dart';
import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Screens/cart_screen.dart';
import 'package:buildadroid/StateManagement/Screens/product_detail_screen.dart';
import 'package:buildadroid/StateManagement/Screens/product_overviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppStateManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: MaterialApp(
        title: "My boutic shop",
        debugShowCheckedModeBanner: false,
        //home: ProductOverviewsScreen(),
        initialRoute: '/',
        routes: {
          '/': (context)=> ProductOverviewsScreen(),
          ProductDetailScreen.routeName : (context)=> ProductDetailScreen(),
          CartScreen.routeName : (context)=> CartScreen(),
        },
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
      ),
    );
  }
}