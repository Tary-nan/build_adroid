import 'package:buildadroid/StateManagement/Widgets/form_register.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit-product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('edit product'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.save), onPressed: (){
        })
      ],
    ),
    body: FormRegister(),
    );
  }
}