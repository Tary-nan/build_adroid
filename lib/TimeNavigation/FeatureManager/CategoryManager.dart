import 'package:buildadroid/TimeNavigation/Models/Category.dart';
import 'package:sprinkle/Manager.dart';
import 'package:rxdart/rxdart.dart';

class CategoryManager implements Manager {

  BehaviorSubject<List<CategoryModel>> _collectionSubject = BehaviorSubject();
  Stream<List<CategoryModel>> get collection$ => _collectionSubject.stream;

  CategoryManager(){
    _collectionSubject.add(DataProvider().dymmyData);
  }

  @override
  void dispose() {
    _collectionSubject.close();
  }
  
}