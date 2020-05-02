import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
     Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'images/face-id-technology-social-card.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'images/icons8-reconnaissance-faciale-100.png',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'images/icons8-empreinte-digitale-100.png',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'images/face-id.png',
    ),
  ];

  var _showFavoriteOnly = false;

  void showFavoriteOnly(){
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll(){
    _showFavoriteOnly = false;
    notifyListeners();
  }
  
  List<Product> get items {
    if(_showFavoriteOnly){
      return _items.where((product)=> product.isfavorite).toList();
    }
    return [..._items];
  }

  void addItem(Product product){
    var newProduct = Product(id: DateTime.now().toString(), title: product.title, price: product.price, imageUrl: product.imageUrl, description: product.description);
    _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateItem(String productId, Product newProduct ){
    final productIndex = _items.indexWhere((existingIndex)=> existingIndex.id == productId);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
      
    }else{
      print("... rien");
    }


  }

  List<Product> get favoriteOnly =>  _items.where((productItem)=> productItem.isfavorite).toList();

  Product findById({String id})=> _items.firstWhere((product)=> product.id == id);

  void removeProduct(String id){
    _items.removeWhere((productItem)=> productItem.id == id);
    notifyListeners();
  }
}