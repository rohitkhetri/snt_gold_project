import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Cart/cart_item.dart';
import 'package:snt_gold_project/Model/cart_model.dart';

class CartPage1 extends StatelessWidget {
  const CartPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];
                return CartItem(
                  name: item["name"],
                  price: item["price"],
                  image: item["image"],
                  quantity: item["quantity"],
                  onRemove: () {
                    cart.removeItem(index);
                  },
                  onIncrease: () {
                    cart.increaseQuantity(index);
                  },
                  onDecrease: () {
                    cart.decreaseQuantity(index);
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("\$${cart.getTotalPrice().toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle Checkout logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 50.0),
                  ),
                  child: const Text(
                    "Checkout",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class CartPage1 extends StatefulWidget {
//   const CartPage1({super.key});

//   @override
//   CartPageState createState() => CartPageState();
// }

// class CartPageState extends State<CartPage1> {
//   List<Map<String, dynamic>> cartItems = [
//     {
//       "name": "Gold Necklace",
//       "price": 1500.0,
//       "image": 'assets/ring.jpg',
//       "quantity": 1
//     },
//     {
//       "name": "Silver Ring",
//       "price": 300.0,
//       "image": 'assets/ring.jpg',
//       "quantity": 2
//     },
//     {
//       "name": "Diamond Bracelet",
//       "price": 2500.0,
//       "image": 'assets/ring.jpg',
//       "quantity": 1
//     }
//   ];

//   // Calculate total price
//   double getTotalPrice() {
//     double total = 0;
//     for (var item in cartItems) {
//       total += item["price"] * item["quantity"];
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Cart Items List
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 return CartItem(
//                   name: cartItems[index]["name"],
//                   price: cartItems[index]["price"],
//                   image: cartItems[index]["image"],
//                   quantity: cartItems[index]["quantity"],
//                   onRemove: () {
//                     setState(() {
//                       cartItems.removeAt(index);
//                     });
//                   },
//                   onIncrease: () {
//                     setState(() {
//                       cartItems[index]["quantity"]++;
//                     });
//                   },
//                   onDecrease: () {
//                     setState(() {
//                       if (cartItems[index]["quantity"] > 1) {
//                         cartItems[index]["quantity"]--;
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//           ),

//           // Total Price & Checkout Button
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                     Text("\$${getTotalPrice().toStringAsFixed(2)}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 const SizedBox(height: 10.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle Checkout logic
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber[600],
//                     padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 50.0),
//                   ),
//                   child: const Text(
//                     "Checkout",
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // CartItem widget, made dynamic and reusable
// class CartItem extends StatelessWidget {
//   final String name;
//   final double price;
//   final String image;
//   final int quantity;
//   final VoidCallback onRemove;
//   final VoidCallback onIncrease;
//   final VoidCallback onDecrease;

//   const CartItem({
//     super.key,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.quantity,
//     required this.onRemove,
//     required this.onIncrease,
//     required this.onDecrease,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               // Product Image
//               Image.asset(
//                 image,
//                 width: 80,
//                 height: 80,
//               ),
//               const SizedBox(width: 16.0),

//               // Product Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Text("\$$price", style: TextStyle(fontSize: 16, color: Colors.amber[600])),
//                   ],
//                 ),
//               ),

//               // Quantity Selector
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: onDecrease,
//                     icon: const Icon(Icons.remove),
//                   ),
//                   Text("$quantity"), // Display quantity
//                   IconButton(
//                     onPressed: onIncrease,
//                     icon: const Icon(Icons.add),
//                   ),
//                 ],
//               ),

//               // Remove Button
//               IconButton(
//                 onPressed: onRemove,
//                 icon: const Icon(Icons.delete, color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
