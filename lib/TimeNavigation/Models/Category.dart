
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryModel {


  CategoryModel({
    Key key,
    @override this.id,
    @override this.title,
    this.color
  });

  final String id;
  final String title;
  final Color color;

}

class DataProvider {

  List<CategoryModel> get dymmyData => _data;

  final List<CategoryModel> _data =  
  [
          CategoryModel(
            id: 'c1',
            title: 'Italian',
            color: Colors.purple,
          ),
          CategoryModel(
            id: 'c2',
            title: 'Quick & Easy',
            color: Colors.red,
          ),
          CategoryModel(
            id: 'c3',
            title: 'Hamburgers',
            color: Colors.orange,
          ),
          CategoryModel(
            id: 'c4',
            title: 'German',
            color: Colors.amber,
          ),
          CategoryModel(
            id: 'c5',
            title: 'Light & Lovely',
            color: Colors.blue,
          ),
          CategoryModel(
            id: 'c6',
            title: 'Exotic',
            color: Colors.green,
          ),
          CategoryModel(
            id: 'c7',
            title: 'Breakfast',
            color: Colors.lightBlue,
          ),
          CategoryModel(
            id: 'c8',
            title: 'Asian',
            color: Colors.lightGreen,
          ),
          CategoryModel(
            id: 'c9',
            title: 'French',
            color: Colors.pink,
          ),
          CategoryModel(
            id: 'c10',
            title: 'Summer',
            color: Colors.teal,
          ),
    ];

  
}