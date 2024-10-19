// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/demo2/api_service.dart';
// import 'package:snt_gold_project/demo2/product.dart';

// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [];
//   bool _isLoading = false;

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;

//   ApiService _apiService = ApiService();

//   Future<void> fetchProducts() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _products = await _apiService.fetchProductList();
//     } catch (e) {
//       print("Error fetching products: $e");
//     }

//     _isLoading = false;
//     notifyListeners();
//   }
// }
