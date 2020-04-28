
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isfavorite = false
  });
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  bool isfavorite;

   void toggleFavoriteStatus(){
    isfavorite = !isfavorite;
    notifyListeners();
  }
  
}