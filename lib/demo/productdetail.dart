// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/demo/product.dart';

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
//             Image.network(product.productImage),
//             const SizedBox(height: 16.0),
//             Text(
//               product.name,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8.0),
//             Text("Product ID: ${product.productId}"),
//             Text("Category: ${product.category}"),
//             Text("Sub Category: ${product.subCategory}"),
//             Text("Brand: ${product.brand}"),
//             const SizedBox(height: 8.0),
//             Text("Description: ${product.productDescription ?? 'No description'}"),
//             const SizedBox(height: 8.0),
//             Text("Return Days: ${product.returnDays}"),
//             Text("Reward Points: ${product.rewardPoints ?? 'N/A'}"),
//             const SizedBox(height: 8.0),
//             Text("Rating: ${product.productRating}"),
//             const SizedBox(height: 8.0),
//             const Text("Size Wise Price:"),
//             // Check if sizeWisePrice is not null and contains data
//             // if (product.sizeWisePrice != null && product.sizeWisePrice!['price'] != null && product.sizeWisePrice!['price'].isNotEmpty) 
//             //   ...product.sizeWisePrice!['price'].asMap().entries.map((entry) {
//             //     int index = entry.key;
//             //     final price = entry.value;
//             //     return Text(
//             //       'Price: $price, Weight: ${product.sizeWisePrice!['weight'][index]}, Carat: ${product.sizeWisePrice!['carat'][index]}, Size: ${product.sizeWisePrice!['size'][index]}, Quantity: ${product.sizeWisePrice!['quantity'][index]}',
//             //     );
//             //   }).toList()
//             // else
//             //   const Text('No size-wise prices available.'),
//           ],
//         ),
//       ),
//     );
//   }
// }