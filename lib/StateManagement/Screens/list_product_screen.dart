import 'package:buildadroid/StateManagement/FeatureProviders/provider.dart';
import 'package:buildadroid/StateManagement/Screens/edit_product_screen.dart';
import 'package:buildadroid/StateManagement/Widgets/app_drawer.dart';
import 'package:buildadroid/StateManagement/Widgets/list_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductScreen extends StatefulWidget {

  static const routeName = '/list-product';

  @override
  _ListProductScreenState createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {

  bool _isInit = true;
  bool _loading = false;


  @override
  void didChangeDependencies()async {
    if (_isInit) {
      setState(() {
        _loading = true;
      });

      await Provider.of<Products>(context, listen: false).fetchDataFromServerWeb().then((_){
        setState(() {
          _loading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title:Text('list of product'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: ()=> Navigator.pushNamed(context, EditProductScreen.routeName)),
      ],
    ),
    body :_loading? Center(child: CircularProgressIndicator(),) : ListView.builder(
      itemCount: product.items.length,
      itemBuilder: (context, index)=> ChangeNotifierProvider.value(
        child: ListProductItem(),
        value: product.items[index], )
      ),
    );
  }
}