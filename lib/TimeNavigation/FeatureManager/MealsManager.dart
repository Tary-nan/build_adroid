import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';

class MealsManager implements Manager {

  List<Meal> _data = DataProviderMeal().dataMeal;

  BehaviorSubject<List<Meal>> _collectionSubject = BehaviorSubject();
  BehaviorSubject<Meal> _detailSubject = BehaviorSubject();
  BehaviorSubject<String> _complexitySubject = BehaviorSubject();

  Stream<List<Meal>> get collection$ => _collectionSubject.stream;
  Stream<Meal> get detail$ => _detailSubject.stream;
  Stream<String> get complexityText$ => _complexitySubject.stream;

  void removeMeal(String id){
     _data.removeWhere((x)=> x.id == id);
     _collectionSubject.add(_data);

  }


  void setComplixity(Complexity complexity){
    switch (complexity) {
      case Complexity.Challenging:
         _complexitySubject.sink.add("Challenging");
        break;
      case Complexity.Hard:
        _complexitySubject.sink.add("Hard");
        break;
      case Complexity.Simple:
        _complexitySubject.sink.add("Simple");
        break;
      default:
        _complexitySubject.sink.add("Unknow");
    }
  }


  void searchListItem({String id}){
  
    List<Meal> data = _data
    .where((meals)=>
       meals.categories.contains(id)).toList();

    if(data.isEmpty){
      _collectionSubject.addError("object vide");
    }else{
        _collectionSubject.sink.add(data);

    }
   
  }

  void searchDetailMealById({String id}){
    Meal meals = DataProviderMeal().dataMeal.firstWhere((x)=> x.id == id);
    _detailSubject.add(meals);
  }


  @override
  void dispose() {
    _collectionSubject.close();
    _complexitySubject.close();
    _detailSubject.close();
  }
  
}
