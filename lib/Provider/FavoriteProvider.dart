import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';

class Favoriteprovider with ChangeNotifier {
  final List<Product> _favoriteProducts = []; 

  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }


  void addFavorite(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Product product) {
    _favoriteProducts.remove(product);
    notifyListeners(); 
  }

  List<Product> get favoriteProducts => _favoriteProducts;
}
