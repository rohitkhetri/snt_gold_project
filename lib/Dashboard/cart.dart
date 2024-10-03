import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  int quantity = 1; // Default quantity for the cart items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.amber[600],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous page
          },
        ),
      ),
      body: Column(
        children: [
          // Cart Items List
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Example item count
              itemBuilder: (context, index) {
                return const CartItem();
              },
            ),
          ),

          // Total Price & Checkout Button
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("\$4500", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Example total price
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle Checkout logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[600],
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 100.0),
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

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Product Image
              Image.network(
                "https://example.com/product-image.png",
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 16.0),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gold Necklace",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text("\$1500", style: TextStyle(fontSize: 16, color: Colors.amber[600])),
                  ],
                ),
              ),

              // Quantity Selector
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Decrease quantity
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const Text("1"), // Display quantity
                  IconButton(
                    onPressed: () {
                      // Increase quantity
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              // Remove Button
              IconButton(
                onPressed: () {
                  // Remove item from cart
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
