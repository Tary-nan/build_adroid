import 'dart:convert';

import 'package:buildadroid/StateManagement/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {

  List<Product> _items = [
    //  Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'images/face-id-technology-social-card.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'images/icons8-reconnaissance-faciale-100.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'images/icons8-empreinte-digitale-100.png',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'images/face-id.png',
    // ),
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

  Future<void> fetchDataFromServerWeb()async{
    final String url = 'https://flutter-shoping.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;

      if (extractData == null) {
        return;
      }
      List<Product> loadProduct = [];
      extractData.forEach((proId, values){
        loadProduct.add(
          Product(
            id: proId, 
            title: values['title'], 
            description: values['description'], 
            imageUrl: values['imageUrl'], 
            price: values['price'],
            isfavorite: values['isFavorite']
            ));
      });

      _items = loadProduct;
      print(_items.length);
      notifyListeners();
      
    } catch (e) {
      throw e;
    }
    
  }

  Future<void> addItem(Product product)async{
    final String url = 'https://flutter-shoping.firebaseio.com/products.json';
    final Map<String, dynamic> data = {
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isfavorite,
    };
    try{
      http.Response response = await http.post(url, body: json.encode(data));
      var newProduct = Product(
        id: json.decode(response.body)['name'], 
        title: product.title, 
        price: product.price, 
        imageUrl: product.imageUrl, 
        description: product.description
        );

      _items.insert(0, newProduct);
      notifyListeners();

    }catch(error){
      throw error;
    }
    
  }

  Future<void> updateItem(String productId, Product newProduct )async{
    final productIndex = _items.indexWhere((existingIndex)=> existingIndex.id == productId);
    if (productIndex >= 0) {
      final String url = 'https://flutter-shoping.firebaseio.com/products/$productId.json';
      final Map<String, dynamic> data = {
        'title': newProduct.title,
        'description': newProduct.description,
        'imageUrl': newProduct.imageUrl,
        'price': newProduct.price,
    };
      await http.patch(url, body: json.encode(data));

      _items[productIndex] = newProduct;
      notifyListeners();
    }else{
      print("... rien");
    }
  }

  List<Product> get favoriteOnly =>  _items.where((productItem)=> productItem.isfavorite).toList();

  Product findById({String id})=> _items.firstWhere((product)=> product.id == id);

  Future<void> removeProduct(String id)async{
    final String url = 'https://flutter-shoping.firebaseio.com/products/$id.json';
    // _items.removeWhere((productItem)=> productItem.id == id); use removeat
    final productIndex = _items.indexWhere((existingIndex)=> existingIndex.id == id);
    var existingProduct = _items[productIndex];
    items.removeAt(productIndex);
    notifyListeners();

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(productIndex, existingProduct);
      notifyListeners();
      throw 'Could not delete product.';
    }
    existingProduct = null;
  }
}