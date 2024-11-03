// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/detaildemo/apiservice.dart';
// import 'package:snt_gold_project/detaildemo/product_class.dart';

// class ProductDetailPage extends StatefulWidget {
//   final String productId;

//   const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   late Future<ProductData> _productDetail;

//   @override
//   void initState() {
//     super.initState();
//     _productDetail = ApiService().fetchProductDetail(widget.productId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Detail'),
//       ),
//       body: FutureBuilder<ProductData>(
//         future: _productDetail,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.productDetails.isEmpty) {
//             return const Center(child: Text('Product details not available'));
//           } else {
//             final product = snapshot.data!.productDetails.first; // Assuming you only want the first product

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(
//                     'https://sntgold.microlanpos.com/${product.productImage}',
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     product.name,
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Product ID: ${product.productId}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Description: ${product.productDescription ?? "No description available"}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Category: ${product.category ?? "N/A"}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Brand: ${product.brand ?? "N/A"}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rating: ${product.productRating != null ? product.productRating.toString() : "Not rated"}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   // You can add more details like size, weight, etc., if necessary
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
