import 'package:flutter/material.dart';

class FavoriteItem extends StatefulWidget{
  final String name;
  final double price;
  final String image;


  const FavoriteItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  }) ;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }}



// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/Product_List/all_products.dart';

// abstract class FavoriteProduct extends StatelessWidget {

//   final String name;
//   final String image;
//   final String price;
  
//   const FavoriteProduct({super.key, 
//     required this.name,
//     required this.price,
//     required this.image,
//   });
// }


// //testnew2@gmail.com

// // import 'package:flutter/material.dart';

// // class CartItem extends StatelessWidget {
// //   final String name;
// //   final double price;
// //   final String image;
// //   int quantity;
// //   final String size;
// //   final VoidCallback onRemove;
// //   final VoidCallback onIncrease;
// //   final VoidCallback onDecrease;

// //   CartItem({
// //     super.key,
// //     required this.name,
// //     required this.price,
// //     required this.image,
// //     this.quantity = 1,
// //     required this.size,
// //     required this.onRemove,
// //     required this.onIncrease,
// //     required this.onDecrease,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
// //       child: ListTile(
// //         leading: Image.network(image, width: 50, height: 50, fit: BoxFit.cover),
// //         title: Text(name),
// //         subtitle: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('Size: $size'),
// //             Text('Price: \$${price.toStringAsFixed(2)}'),
// //             Text('Quantity: $quantity'),
// //           ],
// //         ),
// //         trailing: SizedBox(
// //           width: 150, // Set a fixed width for the trailing container
// //           child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                 children: [
// //                   IconButton(
// //                     icon: const Icon(Icons.remove),
// //                     onPressed: onDecrease,
// //                   ),
// //                   Text(quantity.toString()), // Display the quantity
// //                   IconButton(
// //                     icon: const Icon(Icons.add),
// //                     onPressed: onIncrease,
// //                   ),
// //                   IconButton(
// //                     icon: const Icon(Icons.delete),
// //                     onPressed: onRemove,
// //               ),
// //                 ],
// //               ),
// //           ),
// //         ),
// //       );    
// //   }
// // }
