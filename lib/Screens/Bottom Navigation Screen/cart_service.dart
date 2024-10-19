// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/Product_List/all_products.dart';

// class ProductService {
//   static Future<Product> fetchProductDetails(int productId) async {
//     final url = Uri.parse('https://sntgold.microlanpos.com/api/product_list');
//     final headers = {'Content-Type': 'application/json'};

//     try {
//       final response = await http.get(url, headers: headers);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         // Search for product by productId
//         final productData = data['product'].firstWhere((product) => int.parse(product['product_id']) == productId);
//         return Product.fromJson(productData);
//       } else {
//         throw Exception('Failed to load product details');
//       }
//     } catch (e) {
//       print('Error fetching product details: $e');
//       throw Exception('Error fetching product details');
//     }
//   }
// }
