// import 'package:flutter/material.dart';

// class CartItem extends StatelessWidget {
//   final String name;
//   final double price;
//   final String image;
//   int quantity;
//   final String size;
//   final VoidCallback onRemove;
//   final VoidCallback onIncrease;
//   final VoidCallback onDecrease;

//   CartItem({
//     super.key,
//     required this.name,
//     required this.price,
//     required this.image,
//     this.quantity = 1,
//     required this.size,
//     required this.onRemove,
//     required this.onIncrease,
//     required this.onDecrease,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0), // Add padding around the content
//         child: Row(
//           children: [
//             Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
//             const SizedBox(width: 10), // Space between image and text
//             Expanded( // Ensure the text takes available space
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     overflow: TextOverflow.ellipsis, // Prevent overflow
//                   ),
//                   Text('Size: $size'),
//                   Text('Price: \$${price.toStringAsFixed(2)}'),
//                   Text('Quantity: $quantity'),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10), // Space before trailing buttons
//             SizedBox(
//               width: 100, // Fixed width for the trailing container
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.remove),
//                     onPressed: onDecrease,
//                   ),
//                   Text(quantity.toString()), // Display the quantity
//                   IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: onIncrease,
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: onRemove,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }