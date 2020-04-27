import 'package:buildadroid/TimeNavigation/Models/Meals.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';

class MealsManager implements Manager {

  List<Meal> _data = DataProviderMeal().dataMeal;
  List<Meal> _favoritesMeals = [];

  BehaviorSubject<List<Meal>> _collectionSubject = BehaviorSubject();

  BehaviorSubject<List<Meal>> _favoritesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<bool> _isfavoritesSubject = BehaviorSubject.seeded(false);

  Stream<bool> get isFavorite$ => _isfavoritesSubject.stream;

  void toggleFavorite({String mealId}){
    final existingIndex = _favoritesMeals.indexWhere((meal) => meal.id == mealId);
    
    if(existingIndex >= 0){
      // existe
      _favoritesMeals.removeAt(existingIndex);
      _favoritesSubject.add(_favoritesMeals);
    }else{
      // not existe created object
      Meal favorite = DataProviderMeal().dataMeal.firstWhere((meal)=> meal.id == mealId);
      _favoritesMeals.add(favorite);

      _favoritesSubject.add(_favoritesMeals);
    }
  }

  void isFavorite(String mealId)=> _isfavoritesSubject.add(_favoritesMeals.any((meal)=> meal.id == mealId));

 


  BehaviorSubject<Meal> _detailSubject = BehaviorSubject();
  BehaviorSubject<String> _complexitySubject = BehaviorSubject();

  Stream<List<Meal>> get collection$ => _collectionSubject.stream;
  Stream<List<Meal>> get favoriteList$ => _favoritesSubject.stream;
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

        List<Meal> filterMealData = data.where((meal){
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
    if(filterMealData.isEmpty){
        _collectionSubject.addError("after filter object vide");
     }else{

    _collectionSubject.sink.add(filterMealData);
     }   
  }

  void searchDetailMealById({String id}){
    Meal meals = DataProviderMeal().dataMeal.firstWhere((x)=> x.id == id);
    _detailSubject.add(meals);
  }

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

  void submit(){
    List<Meal> filterMealData = DataProviderMeal().dataMeal.where((meal){
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
    _collectionSubject.add(filterMealData);

  }


  @override
  void dispose() {
    _collectionSubject.close();
    _complexitySubject.close();
    _detailSubject.close();
    _swictLactooseFree.close();
    _swicthGluenFree.close();
    _swicthVegan.close();
    _swicthVegetarian.close();
    _favoritesSubject.close();
    _isfavoritesSubject.close();
  }
  
}
