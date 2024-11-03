// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductDetailPagedemosize extends StatefulWidget {
//   final String productId;

//   const ProductDetailPagedemosize({super.key, required this.productId});

//   @override
//   _ProductDetailPagedemosizeState createState() => _ProductDetailPagedemosizeState();
// }

// class _ProductDetailPagedemosizeState extends State<ProductDetailPagedemosize> {
//   String productName = '';
//   String productImage = '';
//   double productPrice = 0.0;
//   double productRating = 0.0;
//   List<String> availableSizes = [];
//   List<String> availableCarats = [];
//   List<String> availableWeights = [];
//   String? selectedSize;
//   String? selectedCarat;
//   String? selectedWeight;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProductDetails();
//   }

//   Future<void> _fetchProductDetails() async {
//   final response = await http.get(Uri.parse('https://sntgold.microlanpos.com/api/product_list'));

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = jsonDecode(response.body);
//     final products = data['product'] as List<dynamic>;

//     // Log the product ID and all received product IDs for debugging
//     print('Searching for product ID: ${widget.productId}');
//     List<String> productIds = products.map((p) => p['product_id'].toString()).toList();
//     print('Available product IDs: $productIds');

//     try {
//       // Find the specific product by productId
//       final product = products.firstWhere((p) => p['product_id'] == widget.productId);

//       setState(() {
//         productName = product['name'];
//         productImage = product['product_image'];
//         productRating = product['product_rating']?.toDouble() ?? 0.0;

//         // Parse size_wise_price
//         final sizeWisePrice = jsonDecode(product['size_wise_price']);
//         availableSizes = List<String>.from(sizeWisePrice['size']);
//         availableCarats = List<String>.from(sizeWisePrice['carat']);
//         availableWeights = List<String>.from(sizeWisePrice['weight']);
//         productPrice = double.tryParse(sizeWisePrice['price'][0]) ?? 0.0; // Default to the first price

//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error: $e'); // Log the error
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product not found')),
//       );
//       setState(() {
//         isLoading = false;
//       });
//     }
//   } else {
//     // Handle error
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Failed to load product details')),
//     );
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

//   // void _addToCart() {
//   //   if (selectedSize != null && selectedCarat != null && selectedWeight != null) {
//   //     // Assuming you have a CartProvider to manage the cart state
//   //     Provider.of<CartProvider>(context, listen: false).addProduct(
//   //       productId: widget.productId,
//   //       productName: productName,
//   //       price: productPrice,
//   //       size: selectedSize!,
//   //       carat: selectedCarat!,
//   //       weight: selectedWeight!,
//   //     );

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('$productName added to cart!')),
//   //     );
//   //   } else {
//   //     // Show an error if selections are not made
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Please select size, carat, and weight')),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(productName)),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Image.network(productImage),
//                   Text(productName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   Text('Price: \$${productPrice.toStringAsFixed(2)}'),
//                   Text('Rating: ${productRating.toString()}'),
                  
//                   // Dropdown for Size
//                   DropdownButton<String>(
//                     hint: const Text('Select Size'),
//                     value: selectedSize,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedSize = value;
//                       });
//                     },
//                     items: availableSizes.map((String size) {
//                       return DropdownMenuItem<String>(
//                         value: size,
//                         child: Text(size),
//                       );
//                     }).toList(),
//                   ),

//                   // Dropdown for Carat
//                   DropdownButton<String>(
//                     hint: const Text('Select Carat'),
//                     value: selectedCarat,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCarat = value;
//                       });
//                     },
//                     items: availableCarats.map((String carat) {
//                       return DropdownMenuItem<String>(
//                         value: carat,
//                         child: Text(carat),
//                       );
//                     }).toList(),
//                   ),

//                   // Dropdown for Weight
//                   DropdownButton<String>(
//                     hint: const Text('Select Weight'),
//                     value: selectedWeight,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedWeight = value;
//                       });
//                     },
//                     items: availableWeights.map((String weight) {
//                       return DropdownMenuItem<String>(
//                         value: weight,
//                         child: Text(weight),
//                       );
//                     }).toList(),
//                   ),

//                   // ElevatedButton(
//                     // onPressed: _addToCart,
//                     // child: Text('Add to Cart'),
//                   // ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
