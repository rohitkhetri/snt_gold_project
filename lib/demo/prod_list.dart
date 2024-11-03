// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/demo/product.dart';


// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   List<Product> products = [];
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   Future<void> fetchProducts() async {
//     try {
//       final response = await http.get(Uri.parse('https://sntgold.microlanpos.com/api/product_list'));

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
//         products = jsonResponse.map((json) => Product.fromJson(json)).toList();
//       } else {
//         errorMessage = 'Failed to load products';
//       }
//     } catch (e) {
//       errorMessage = 'Error: $e';
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : products.isEmpty
//               ? Center(child: Text(errorMessage.isNotEmpty ? errorMessage : 'No products available'))
//               : ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(8),
//                         title: Text(product.name),
//                         subtitle: Text('First Size Price: ₹${product.getFirstSizePrice()}'),
//                         leading: Image.network(
//                           product.productImage,
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }