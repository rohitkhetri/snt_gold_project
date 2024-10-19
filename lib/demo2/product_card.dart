// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/demo2/product.dart';
// import 'package:snt_gold_project/demo2/product_detail_screen.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Image.network(
//           'https://sntgold.microlanpos.com/${product.productImage}',
//           fit: BoxFit.cover,
//           width: 50,
//         ),
//         title: Text(product.name),
//         subtitle: Text('Price: \$${product.sizeWisePrice?.price?.join(', ')}'),
//         trailing: Icon(Icons.arrow_forward),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ProductDetailScreen(product: product),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
