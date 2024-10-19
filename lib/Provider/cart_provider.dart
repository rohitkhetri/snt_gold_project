import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';

class CartProduct {
  final Product product;
  final String? selectedSize;
  final String? selectedCarat;
  final String? selectedWeight;
  final String price;

  CartProduct({
    required this.product,
    this.selectedSize,
    this.selectedCarat,
    this.selectedWeight,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  List<CartProduct> _cartItems = [];

  List<CartProduct> get cartItems => _cartItems;

  void addToCart(CartProduct cartProduct) {
    _cartItems.add(cartProduct);
    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    _cartItems.remove(cartProduct);
    notifyListeners();
  }
}
