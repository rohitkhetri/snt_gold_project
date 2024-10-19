import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';

class CartPage extends StatefulWidget {
  final List<CartProduct> cartItems; // Changed to CartProduct list

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeFromCart(CartProduct cartProduct) {
    setState(() {
      widget.cartItems.remove(cartProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: widget.cartItems.isEmpty
          ? Center(child: Text('No items in the cart'))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final cartProduct = widget.cartItems[index];
                final product = cartProduct.product;

                return Card(
                  child: ListTile(
                    leading: Image.network(
                      'https://sntgold.microlanpos.com/${product.productImage}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Size: ${cartProduct.selectedSize ?? "N/A"}'),
                        Text('Carat: ${cartProduct.selectedCarat ?? "N/A"}'),
                        Text('Weight: ${cartProduct.selectedWeight ?? "N/A"}'),
                        Text('Price: ${cartProduct.price}'),
                        Row(
                          children: [
                            const Text("Quantity: "),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (cartProduct.quantity > 1) {
                                    cartProduct.quantity--;
                                  }
                                });
                              },
                            ),
                            Text('${cartProduct.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  cartProduct.quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeFromCart(cartProduct),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Model to store product details in the cart
class CartProduct {
  final Product product;
  final String? selectedSize;
  final String? selectedCarat;
  final String? selectedWeight;
  final String price;
  int quantity;

  CartProduct({
    required this.product,
    required this.selectedSize,
    required this.selectedCarat,
    required this.selectedWeight,
    required this.price,
    this.quantity = 1, // Default quantity is 1
  });
}

// // // import 'package:flutter/material.dart';
// // // import 'package:snt_gold_project/Product_List/all_products.dart';
// // // import 'package:snt_gold_project/Screens/api_service.dart';

// // // class CategoryListPage extends StatefulWidget {
// // //   @override
// // //   _CategoryListPageState createState() => _CategoryListPageState();
// // // }

// // // class _CategoryListPageState extends State<CategoryListPage> {
// // //   late Future<List<Category>> futureCategories;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     futureCategories = ApiService().fetchCategories();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Categories'),
// // //       ),
// // //       body: FutureBuilder<List<Category>>(
// // //         future: futureCategories,
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           } else if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //             return const Center(child: Text('No categories found'));
// // //           }

// // //           List<Category> categories = snapshot.data!;

// // //           return ListView.builder(
// // //             itemCount: categories.length,
// // //             itemBuilder: (context, index) {
// // //               return ExpansionTile(
// // //                 title: Text(categories[index].name),
// // //                 children: categories[index].subcategories.map((subcategory) {
// // //                   return ListTile(
// // //                     title: Text(subcategory.name),
// // //                     onTap: () {
// // //                       // Navigate to products of selected subcategory
// // //                       Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                           builder: (context) => ProductListPage(
// // //                             subcategory: subcategory,
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   );
// // //                 }).toList(),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // class ProductListPage extends StatelessWidget {
// // //   final Subcategory subcategory;

// // //   const ProductListPage({Key? key, required this.subcategory}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(subcategory.name),
// // //       ),
// // //       body: FutureBuilder<List<Product>>(
// // //         future: ApiService().fetchProducts(),
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           } else if (snapshot.hasError) {
// // //             return Center(child: Text('Error: ${snapshot.error}'));
// // //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //             return const Center(child: Text('No products found'));
// // //           }

// // //           List<Product> products = snapshot.data!;
// // //           // Filter products by subcategory
// // //           List<Product> filteredProducts = products.where((product) => product.subCategory == subcategory.name).toList();

// // //           // Debugging: Print the filtered products
// // //           print('Filtered Products: $filteredProducts');

// // //           return ListView.builder(
// // //             itemCount: filteredProducts.length,
// // //             itemBuilder: (context, index) {
// // //               return ListTile(
// // //                 title: Text(filteredProducts[index].name),
// // //                 leading: Image.network(
// // //                   'https://sntgold.microlanpos.com/${filteredProducts[index].productImage}',
// // //                   width: 50,
// // //                   height: 50,
// // //                   errorBuilder: (context, error, stackTrace) {
// // //                     return const Icon(Icons.error); // Placeholder for image errors
// // //                   },
// // //                 ),
// // //                 subtitle: Text('Product ID: ${filteredProducts[index].productId}'),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/Model/cart_model.dart';
// import 'package:snt_gold_project/Provider/cart_provider.dart';

// class CartPage1 extends StatefulWidget {
//   const CartPage1({super.key});

//   @override
//   _cartPageState createState() => _cartPageState();
// }
// class _cartPageState extends State<CartPage1> {
//   // final int _selectedSortOption = 1;
//   List<Product> _products = [];
//   // List<Product> _displayedProducts = []; // Add this to manage displayed products
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts(); // Fetch products initially
//   }

//   Future<void> _fetchProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
//         headers: {"Content-Type": "application/json"},
//       );

//       if(response.statusCode == 200){
//         Map<String, dynamic> data = jsonDecode(response.body);
//         List<dynamic> productsJson = data['product'];
//         setState(() {
//           _products = productsJson.map((json) => Product.fromJson(json)).toList();
//           _isLoading = false;
//         });
//       } else {
//         throw Exception("Failed to load products");
//       }
//     } catch (e) {
//       print("Error fetching products: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // Function to update displayed products based on applied filters 
//   // void _updateProducts(List<Product> filteredProducts) {
//   //   setState(() {
//   //     _displayedProducts = filteredProducts; // Update displayed products
//   //   });
//   // }


//   @override
//   Widget build(BuildContext context) {
//     // final cart = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Cart")),
//       body: Column(
//         children: [
//           // Expanded(
//           //   child: cart.isEmpty
//           //       ? const Center(child: Text("Your cart is empty"))
//           //       : ListView.builder( // Directly use ListView.builder
//           //           itemCount: cart.cartItems.length,
//           //           itemBuilder: (context, index) {
//           //             final item = cart.cartItems[index];
//           //             return CartItem(
//           //               name: item.name,
//           //               price: item.price,
//           //               image: item.image,
//           //               quantity: item.quantity,
//           //               size: item.size,
//           //               onRemove: () => cart.removeItem(index),
//           //               onIncrease: () => cart.increaseQuantity(index),
//           //               onDecrease: () => cart.decreaseQuantity(index),
//           //             );
//           //           },
//           //         ),
//           // ),
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             color: Colors.white,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Total",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       // "\$${cart.getTotalPrice().toStringAsFixed(2)}",
//                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
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
