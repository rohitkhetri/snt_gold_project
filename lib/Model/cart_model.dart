import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> item) {
    // // Check if item already exists
    // final existingItemIndex = _cartItems.indexWhere((element) => element['name'] == item['name']);
    // if (existingItemIndex >= 0) {
    //   // Increase quantity if item already exists
    //   _cartItems[existingItemIndex]['quantity']++;
    // } else {
    //   // Add new item if it doesn't exist
    //   _cartItems.add(item);
    // }

    // Convert the price to double if it is an int
    item['price'] = (item['price'] as num).toDouble();
    cartItems.add(item);
    notifyListeners();
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += (item["price"] as num).toDouble() * item["quantity"];
    }
    return total;
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]["quantity"]++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]["quantity"] > 1) {
      _cartItems[index]["quantity"]--;
      notifyListeners();
    }
  }
}
