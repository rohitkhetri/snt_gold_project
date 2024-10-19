// import 'package:flutter/material.dart';

// class SubCategoryPage extends StatelessWidget {
//   final String subCategoryName;
//   final List<dynamic> productList;

//   const SubCategoryPage({super.key, required this.subCategoryName, required this.productList});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products for $subCategoryName'),
//       ),
//       body: ListView.builder(
//         itemCount: productList.length,
//         itemBuilder: (context, index) {
//           var product = productList[index];
//           return ListTile(
//             title: Text(product['name'] ?? 'Unnamed Product'),
//             subtitle: Text('Price: ${product['size_wise_price']}'),
//             trailing: product['product_image'] != null
//                 ? Image.network(
//                     'https://sntgold.microlanpos.com/' + product['product_image'],
//                     width: 50,
//                     height: 50,
//                   )
//                 : null,
//           );
//         },
//       ),
//     );
//   }
// }
