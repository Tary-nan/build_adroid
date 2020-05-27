import 'package:buildadroid/Expenses/FeatureManager/ExpenseManager.dart';
import 'package:buildadroid/Expenses/FeatureManager/FormManager.dart';
import 'package:buildadroid/Expenses/Models/ExpenseModel.dart';
import 'package:buildadroid/Expenses/helpers/ensure_visible.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/SprinkleExtension.dart';

class EditExpense extends StatefulWidget {
  static const routName = '/edit'; 
  @override
  _EditExpenseState createState() => _EditExpenseState();
}

class _EditExpenseState extends State<EditExpense> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _name = FocusNode();
  final FocusNode _price = FocusNode();

  var _isInit = true;

  var _editExpense = ExpenseModel(
    name: '',
    price: 0
  );

  var _initValues = {
    'name': '',
    'price': '',
  };

  @override
  void didChangeDependencies() {
    // implement didChangeDependencies
    super.didChangeDependencies();

    if(_isInit){
      final expenseId = ModalRoute.of(context).settings.arguments as String;
      if (expenseId != null) {
        // update  _editExpense
        _editExpense = context.fetch<ExpenseManager>().findById(expenseId);
        // upadte _initialValues

        _initValues = {
          'name' : _editExpense.name,
          'price' : _editExpense.price.toString(),
        };
      }
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
        FormManager formManager = context.fetch<FormManager>(); 
        ExpenseManager manager = context.fetch<ExpenseManager>(); 

        Widget _buildNameTextFiled() {
          return StreamBuilder(
            stream: formManager.name$,
            builder: (context, snapshot) {
              return EnsureVisibleWhenFocused(
                focusNode: _name,
                child: TextFormField(
                  initialValue: _initValues['name'],
                  onChanged: formManager.setName,
                  onSaved: (newValues){
                    _editExpense = ExpenseModel(id: _editExpense.id,name: newValues, price: _editExpense.price);
                  },
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorText: snapshot.error,
                      labelText: "Nom",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              );
            }
          );
    }

    Widget _buildPriceTextFiled() {
        return StreamBuilder(
          stream: formManager.price$,
          builder: (context, snapshot) {
            return EnsureVisibleWhenFocused(
              focusNode: _price,
              child: TextFormField(
                initialValue: _initValues['price'],
                onChanged: formManager.setPrice,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.number,
                onSaved: (newValues){
                  _editExpense = ExpenseModel(id: _editExpense.id ,name: _editExpense.name, price: double.parse(newValues));
                },
                decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            );
          }
        );
    }

    Future<void> _submitForm() async {     
      // final isValid = _formKey.currentState.validate();
      // if (!isValid) {
      //   return;
      // }
      _formKey.currentState.save();
      manager.updateExpense(_editExpense.id, _editExpense);
      Navigator.pop(context);
}

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: formManager.isFormValid$,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return IconButton(icon: Icon(Icons.save), onPressed: (){
                _submitForm();
              });
            }
          )
        ],
        
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ListTile(title: _buildNameTextFiled()),
            ListTile(title: _buildPriceTextFiled()),
          ],)),
      
    );
  }
}

