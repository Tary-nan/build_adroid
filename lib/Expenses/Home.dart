import 'package:buildadroid/Expenses/FeatureManager/ExpenseManager.dart';
import 'package:buildadroid/Expenses/FeatureManager/FormManager.dart';
import 'package:buildadroid/Expenses/FeatureManager/register.dart';
import 'package:buildadroid/Expenses/Models/ExpenseModel.dart';
import 'package:buildadroid/Expenses/helpers/ensure_visible.dart';
import 'package:flutter/material.dart';
import 'package:sprinkle/Observer.dart';
import 'package:sprinkle/SprinkleExtension.dart';
import 'package:flutter/cupertino.dart';

class HomeExpenses extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _name = FocusNode();
  final FocusNode _price = FocusNode();

  @override
  Widget build(BuildContext context) {

    ExpenseManager manager = context.fetch<ExpenseManager>();
    FormManager formManager = context.fetch<FormManager>();
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text("Expense"),
    );
    

    void _submitForm() async {
          ExpenseModel layout = await formManager.submit();
          // save
          manager.addTransaction(layout);
          Navigator.of(context).pop();
        }

    Widget _buildNameTextFiled() {
          return StreamBuilder(
            stream: formManager.name$,
            builder: (context, snapshot) {
              return EnsureVisibleWhenFocused(
                focusNode: _name,
                child: TextField(
                  onChanged: formManager.setName,
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
              child: TextField(
                onChanged: formManager.setPrice,
                enableInteractiveSelection: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            );
          }
        );
    }

    void addTransaction(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
            ListTile(title: _buildNameTextFiled()),
            ListTile(title: _buildPriceTextFiled()),
            ListTile(
              title: Observer<bool>(
                stream: formManager.isFormValid$, 
                onError: (context, eeror)=> Container(),
                onWaiting: (context)=> RaisedButton(
                    child: Text("save"),
                    onPressed: (){}
                  ),
                onSuccess: (context, data) {
                  return RaisedButton(
                    child: Text("save"),
                    onPressed: _submitForm
                  );
                }
              ),
            )
          ],))
        );

      });
    }
    return Scaffold(
      appBar: appBar,
      body: Observer(
        stream: manager.collection$,
        onSuccess: (context, List<ExpenseModel> datas) {
          return datas.isEmpty ? Container(
            child: Observer(
              stream: manager.switch$,
              onSuccess: (context, data) {
                return Center(
                  child: Switch(value: data, onChanged: manager.setSwitch,
               ),
                );
              }
            )): Builder(
            builder: (context) => LayoutBuilder(
              builder:(context, constraints)=> SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container( 
                        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top ) * 0.3,
                        child: Card(
                            elevation: 6,
                            margin: EdgeInsets.all(constraints.maxHeight * .03),
                            child: Padding(
                              padding: EdgeInsets.all(constraints.maxHeight * .015),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: datas.map((data) {
                                  return Flexible(
                                    fit: FlexFit.tight,
                                    child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: constraints.maxHeight * .03,
                                        child: FittedBox(
                                          child: Text('\$${data.price.toString()}'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * .0066,
                                      ),
                                      Container(
                                        height: constraints.maxHeight * .1,
                                        width: constraints.maxHeight * .015,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey, width: 1.0),
                                                color: Color.fromRGBO(220, 220, 220, 1),
                                                borderRadius: BorderRadius.circular(constraints.maxHeight * .015),
                                              ),
                                            ),
                                            FractionallySizedBox(
                                              //heightFactor: spendingPctOfTotal,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(constraints.maxHeight * .015),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * .0066,
                                      ),
                                      Container(
                                        height: constraints.maxHeight * 0.02,
                                        child: FittedBox(child: Text("${data.name}"))),
                                    ],
                      ),
                                  );
                                }).toList(),
                              ),
                            ),
                      ),
                    )),
                    Flexible(
                      fit: FlexFit.loose,
                      flex: 2, child: Container(
                        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top )  * 0.7,
                        child: ExpenseListBulder(constraints: constraints,manager: manager, mediaQuery: mediaQuery, appBar: appBar))),

                  ]
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: addTransaction,),
      
    );
  }
}

class ExpenseListBulder extends StatelessWidget {
  const ExpenseListBulder({
    Key key,
    @required this.manager,
    @required this.mediaQuery,
    @required this.appBar,
    @required this.constraints,
  }) : super(key: key);

  final ExpenseManager manager;
  final MediaQueryData mediaQuery;
  final AppBar appBar;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Observer<List<ExpenseModel>>(
    stream: manager.collection$,
    onSuccess: (context, List<ExpenseModel> data) {
      return ListView.builder(
        itemBuilder: (context, index){
          return ListTile(
            title: Text(data[index].name, style: TextStyle(color:Colors.black, fontSize: constraints.maxHeight * .025 , fontWeight: FontWeight.bold),),
            subtitle: Text(data[index].date.toString(), style: TextStyle(color:Colors.black45, fontSize: constraints.maxHeight * .021 ),),
            leading: _buildLeading(context, data, index),
            trailing: mediaQuery.size.width < 445 
            ? _deleteButtonOnLandscape(context,data, index)
            : _deleteButtonBuild(data, index),
          
          );
        },
        itemCount: data.length,
        );
    }
                    );
  }

  Container _buildLeading(BuildContext context, List<ExpenseModel> data, int index) {
    return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            child: CircleAvatar(
              child: Text("\$${data[index].price.toStringAsFixed(2)}", style: TextStyle(fontSize: constraints.maxHeight * .021),)
            )
          );
  }

  Widget _deleteButtonOnLandscape(context, List<ExpenseModel> data, int index) {
    return Container(
            width: mediaQuery.size.width / 4.2,
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.delete, color: Colors.red.shade300, ),
                onPressed: ()=> manager.deleteTransaction(data[index].id),
          ),
          IconButton(icon: Icon(Icons.edit, color: Colors.blue.shade300, ),
                onPressed: ()=> Navigator.pushNamed(context, EditExpense.routName, arguments: data[index].id,
          ),
          )],
            ),
        );
  }

  Widget _deleteButtonBuild(List<ExpenseModel> data, int index) {
    return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("delete", style: TextStyle(color: Colors.red.shade300),),
                  IconButton(icon: Icon(Icons.delete, color: Colors.red.shade300, ),
                  onPressed: ()=> manager.deleteTransaction(data[index].id),
            ),
                ],
              ),
          );
  }
}

