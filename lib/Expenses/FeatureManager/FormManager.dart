import 'package:buildadroid/Expenses/Models/ExpenseModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:buildadroid/Expenses/Models/Validation.dart';
import 'package:sprinkle/Manager.dart';

class FormManager with Validation implements Manager {


  /// ************************
  /// *****  NAME CONTROLLER
  ///

  BehaviorSubject<String> _name = BehaviorSubject<String>();
  void setName(String value) => _name.sink.add(value);
  Stream<String> get name$ => _name.stream.transform(validateName);


  /// ************************
  /// *****  NAME CONTROLLER
  ///

  BehaviorSubject<double> _price = BehaviorSubject<double>();
  void setPrice(String value) => _price.sink.add(double.parse(value));
  Stream<double> get price$ => _price.stream.transform(validatePrice);

  Stream<bool> get isFormValid$ => Rx.combineLatest([name$, price$], (value)=> true);

  Future<ExpenseModel> submit()async{
    
    return ExpenseModel(
      name: _name.value,
      price: _price.value,
      date: DateTime.now()
    );
  }


  @override
  void dispose() {
    _name.close();
    _price.close();
  }
  
}