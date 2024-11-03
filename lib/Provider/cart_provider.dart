import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners(); // Notify listeners to rebuild the UI
  }

//   double get totalAmount {
//   return _cartItems.fold(0, (sum, item) => sum + (item.sizeWisePrice ?? 0) * (item.quantity ?? 1));
// }

  void updateQuantity(Product product, int newQuantity) {
    final index = _cartItems.indexOf(product);
    if (index != -1) {
      _cartItems[index].quantity =
          newQuantity; // Adjust this based on your Product class
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
