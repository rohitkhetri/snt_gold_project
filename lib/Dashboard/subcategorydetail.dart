// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class SubcategoryDetailPage extends StatefulWidget {
//   // final String category;
//   // final String subcategory;

//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   List<String> categories = [];
//   List<String> subcategories = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchProductData();
//   }

//   Future<void> fetchProductData() async {
//     final response = await http.get(Uri.parse('https://sntgold.microlanpos.com/api/product_list'));

//     if(response.statusCode == 200){
//       final data = json.decode(response.body);
//       final products = data['product'] as List;

//       Set<String> categorySet = {};
//       Set<String> subCategorySet = {};

//       for(var product in products) {
//         categorySet.add(product['category']);
//         subCategorySet.add(product['sub_category']);
//       }

//       setState(() {
//         categories = categorySet.toList();
//         subcategories = subCategorySet.toList();
//       });
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$subcategory - $category'),
//       ),
//       body: Center(
//         child: Text(
//           'Details for $subcategory in $category',
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
