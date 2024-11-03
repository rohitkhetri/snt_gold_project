// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
// import 'package:snt_gold_project/detaildemo/product_class.dart';

// class ApiService {
//   // Fetch product list
//   Future<List<Product>> fetchProductList() async {
//     final response = await http.get(Uri.parse('https://sntgold.microlanpos.com/api/product-list'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((productJson) => Product.fromJson(productJson)).toList();
//     } else {
//       throw Exception('Failed to load product list');
//     }
//   }

//   // Fetch product detail by ID
//   Future<ProductData> fetchProductDetail(String productId) async {
//     final response = await http.get(Uri.parse('https://sntgold.microlanpos.com/api/product-detail/$productId'));

//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       return ProductData.fromJson(jsonData['product_data']);
//     } else {
//       throw Exception('Failed to load product detail');
//     }
//   }
// }
