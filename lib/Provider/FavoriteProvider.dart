import 'package:flutter/material.dart';
import 'package:snt_gold_project/Model/favorite_model.dart';

class Favoriteprovider extends ChangeNotifier{

  final List<FavoriteProduct> _favorites = [];
  List<FavoriteProduct> get favorites => _favorites;

  void addFavorite(FavoriteProduct product){
    _favorites.add(product);
    notifyListeners();
  }

  void removeFavorite(FavoriteProduct product){
    _favorites.remove(product);
    notifyListeners();
  }

  bool isFavorite(FavoriteProduct product){
    return _favorites.contains(product);
  }
}