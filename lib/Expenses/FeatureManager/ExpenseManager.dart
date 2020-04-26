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

  void setSwitch(bool value)=> _swicth.sink.add(value);

  // Input

 void addTransaction(ExpenseModel value){
   _data.insert(0, value);
   _collectionSubject.sink.add(_data);
 }

 void deleteTransaction(String title){
   _data.removeWhere((x)=> x.name == title);
   _collectionSubject.add(_data);
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