import 'package:buildadroid/Expenses/Models/ExpenseModel.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';


class ExpenseManager implements Manager {

  List<ExpenseModel> _data = DataProvider.data;

  // Controller
  BehaviorSubject<List<ExpenseModel>> _collectionSubject = BehaviorSubject();
  BehaviorSubject<bool> _swicth = BehaviorSubject.seeded(false);
  
  //Ouput
  Stream<List<ExpenseModel>> get collection$ => _collectionSubject.stream; 
  Stream<bool> get switch$ => _swicth.stream; 

  void _notify(){
    _collectionSubject.sink.add(_data);
  }

  void setSwitch(bool value)=> _swicth.sink.add(value);

  ExpenseModel findById(String id)=> _data.firstWhere((expense)=> expense.id == id);
  
  void updateExpense(String expenseId, ExpenseModel expense){
    var newExpense = ExpenseModel(
      id: expense.id,
      name: expense.name,
      price: expense.price,
      date: DateTime.now(),
    );
    
    final existingIndex = _data.indexWhere((expense)=> expense.id == expenseId);
    if (existingIndex >= 0) {
      // new product
      _data[existingIndex] = newExpense;
      _notify();
    }
  }

  // Input

 void addTransaction(ExpenseModel expense){
   var newExpense = ExpenseModel(
     id: DateTime.now().toString(),
     name: expense.name,
     price: expense.price,
     date: expense.date
  );
   _data.insert(0, newExpense);
   _notify();
 }

 void deleteTransaction(String expenseId){
  //  _data.removeWhere((x)=> x.id == expenseId); use on local 
  final existingIndex = _data.indexWhere((expense)=> expense.id == expenseId);
  if (existingIndex >= 0) {
      _data.removeAt(existingIndex);
      // new product
      // var existingProduct =_data[existingIndex]; 
      // use with a server lorsque statusCosde >= 400 
      // on remet a sa place _data.insert(existingIndex, existingProduct);
      _notify();
    }
 }

  List<ExpenseModel> get recentTransactions {
    // recent transaction 
    return _data.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  

  ExpenseManager(){

    //   var ok = List.generate(7, (index) => DateTime.now().subtract(
    //     Duration(days: index),
    //   )).reversed.toList();

    //   var oka = ok.where((x)=> x.isAfter(DateTime.now().subtract(Duration(days: 3)))).toList();

    //   final weekDay = DateTime.now().subtract(
    //     Duration(days: 1),
    //   );

    //   var p = ok.where((x)=> x.isBefore(DateTime.now().subtract(Duration(days: 3)))).toList();

    // _data.where((x)=> x.date.isAfter(DateTime.now().subtract(Duration(seconds: 2)))).toList();
    _collectionSubject.add(_data);
  }


  @override
  void dispose() {
    _collectionSubject.close();
    _swicth.close();
  }
  
}