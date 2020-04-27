import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sprinkle/Manager.dart';
class FiltersManager implements Manager {
  

  List<Meal> _data = DataProviderMeal().dataMeal;

  BehaviorSubject<bool> _swicthGluenFree = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _swicthVegan = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _swicthVegetarian = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _swictLactooseFree = BehaviorSubject.seeded(false);

  Stream<bool> get gluentenFree$ => _swicthGluenFree.stream; 
  Stream<bool> get vegan$ => _swicthVegan.stream; 
  Stream<bool> get vegetarian$ => _swicthVegetarian.stream; 
  Stream<bool> get lactooseFree$ => _swictLactooseFree.stream; 

  void setGluenFree(bool value)=> _swicthGluenFree.sink.add(value);
  void setVegan(bool value)=> _swicthVegan.sink.add(value);
  void setVegetarian(bool value)=> _swicthVegetarian.sink.add(value);
  void setLactooseFree(bool value)=> _swictLactooseFree.sink.add(value);

  Stream<bool> get isSaved => 
      Rx.combineLatest([gluentenFree$, vegetarian$, vegan$, lactooseFree$], (value)=> true);

  submit(){
    List<Meal> filterMealData = _data.where((meal){
      if(_swicthGluenFree.value && !meal.isGlutenFree){
          return false;
      }
      if(_swicthVegan.value && !meal.isVegan){
          return false;
      }
      if(_swicthVegetarian.value && !meal.isVegetarian){
          return false;
      }
      if(_swictLactooseFree.value && !meal.isLactoseFree){
          return false;
      }
      return true;
    }).toList();
    return filterMealData;
  }


  @override
  void dispose() {
    _swictLactooseFree.close();
    _swicthGluenFree.close();
    _swicthVegan.close();
    _swicthVegetarian.close();
  }
  
}