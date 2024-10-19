// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/demo2/product.dart';
// import 'package:snt_gold_project/demo2/product_detail_screen.dart';

// class ProductScreen extends StatefulWidget {
//   const ProductScreen({super.key});

//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   List<Product> _products = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProductList();
//   }

//   Future<void> fetchProductList() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
//         headers: {"Content-Type": "application/json"},
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = jsonDecode(response.body);
//         List<dynamic> productsJson = data['product'];
//         setState(() {
//           _products = productsJson.map((json) => Product.fromJson(json)).toList();
//           _isLoading = false;
//         });
//       } else {
//         throw Exception("Failed to load products");
//       }
//     } catch (e) {
//       print("Error fetching products: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _products.isEmpty
//               ? const Center(child: Text('No products available.'))
//               : ListView.builder(
//                   itemCount: _products.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: ListTile(
//                         leading: Image.network(
//                           'https://sntgold.microlanpos.com/${_products[index].productImage}',
//                           fit: BoxFit.cover,
//                           width: 50,
//                         ),
//                         title: Text(_products[index].name),
//                         subtitle: Text('Price: \$${_products[index].sizeWisePrice?.price?.join(', ')}'),
//                         trailing: const Icon(Icons.arrow_forward),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetailScreen(product: _products[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
