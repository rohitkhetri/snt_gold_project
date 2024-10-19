// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/demo2/product.dart';

// class ProductDetailScreen extends StatelessWidget {
//   final Product product;

//   const ProductDetailScreen({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               'https://sntgold.microlanpos.com/${product.productImage}',
//               width: double.infinity,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               product.name,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Price: \$${product.sizeWisePrice?.price?.join(', ')}',
//               style: const TextStyle(fontSize: 20, color: Colors.green),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Rating: ${product.productRating}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Return Days: ${product.returnDays}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             product.productDescription != null
//                 ? Text(
//                     'Description: ${product.productDescription}',
//                     style: const TextStyle(fontSize: 16),
//                   )
//                 : const Text(
//                     'No description available.',
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//             const SizedBox(height: 16),
//             const Text(
//               'Specification:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             product.productSpecification != null
//                 ? Text(product.productSpecification ?? '')
//                 : const Text(
//                     'No specification available.',
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
