// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/Product_List/all_products.dart';

// class ApiService {
//   final String productApiUrl = 'https://sntgold.microlanpos.com/api/product_list';

//   Future<List<Product>> fetchProducts() async {
//     final response = await http.get(Uri.parse(productApiUrl));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body)['product'] as List;
//       return data.map((item) => Product.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   Future<List<Category>> fetchCategories() async {
//     // Dummy categories and subcategories for this example
//     return [
//       Category(
//         name: 'Jewelry',
//         id: '1',
//         subcategories: [
//           Subcategory(name: 'Earrings', categoryId: '1'),
//           Subcategory(name: 'Necklaces', categoryId: '1'),
//         ],
//       ),
//       Category(
//         name: 'Watches',
//         id: '2',
//         subcategories: [
//           Subcategory(name: 'Men\'s Watches', categoryId: '2'),
//           Subcategory(name: 'Women\'s Watches', categoryId: '2'),
//         ],
//       ),
//     ];
//   }
// }
