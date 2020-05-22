import 'package:buildadroid/ReaciveProgramming/blocs/bloc_provider.dart';
import 'package:buildadroid/ShoppingCartBloc/bloc/bloc_shopping_bloc.dart';
import 'package:buildadroid/ShoppingCartBloc/bloc/bloc_shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Shopping Page'),
        actions: <Widget>[
          
          Row(
            children: <Widget>[
              Observer(
                stream: bloc.shoppingBasket,
                onSuccess: (context, data) {
                  return Text(data.length.toString());
                }
              ),
              Icon(Icons.shopping_cart),
            ],
          ),
          //ShoppingBasket(),
        ],
      ),
      body: Container(
        child: StreamBuilder<List<ShoppingItem>>(
          stream: bloc.items,
          builder: (BuildContext context,
              AsyncSnapshot<List<ShoppingItem>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ShoppingItemWidget(
                  shoppingItem: snapshot.data[index],
                );
              },
            );
          },
        ),
      ),
    ));
  }
}