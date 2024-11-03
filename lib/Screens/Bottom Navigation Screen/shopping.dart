import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Model/productfilterpage.dart';
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart'; // Adjust import paths as necessary
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  int _selectedSortOption = 1;

  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> productsJson = data['product'];
        setState(() {
          _products =
              productsJson.map((json) => Product.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Gold Jewellery || 0% off on M..."),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductFilterPage()),
                );
              },
              icon: const Icon(Icons.filter_list)),
          IconButton(
            onPressed: () => showSortBottomSheet(context),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: _products.length = 2,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              productId: int.parse(product.productId),
                              productdetail: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 6,
                      shadowColor: Colors.grey.withOpacity(0.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            child: Image.network(
                              'https://sntgold.microlanpos.com/${product.productImage}',
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image,
                                    size: 100, color: Colors.grey);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '₹${product.sizeWisePrice?.price?.first ?? 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 4),
                          buildStarRating(
                              product.productRating?.toDouble() ?? 0.0),
                          const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFE4B062), // Gold color accent
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15)),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                'View Details',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Price (lowest first)'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Relevance'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Discount'),
                leading: Radio<int>(
                  value: 3,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Price (highest first)'),
                leading: Radio<int>(
                  value: 4,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('What\'s New'),
                leading: Radio<int>(
                  value: 5,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:snt_gold_project/Product_List/all_products.dart'; // Adjust import paths as necessary
// // import 'package:snt_gold_project/Screens/filter_screen.dart'; // Adjust import paths as necessary
// import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart'; // Adjust import paths as necessary

// class ShoppingPage extends StatefulWidget {
//   const ShoppingPage({super.key});

//   @override
//   _ShoppingPageState createState() => _ShoppingPageState();
// }

// class _ShoppingPageState extends State<ShoppingPage> {
//   // final int _selectedSortOption = 1;
//   List<Product> _products = [];
//   // List<Product> _displayedProducts = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchProducts();
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
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Products'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: () {
//               // Navigate to filter screen and pass current products
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => FilterScreen(
//               //       allProducts: _fetchProducts,
//               //       // onFiltersApplied: _updateProducts, // Pass function to handle applied filters
//               //     ),
//                 // ),
//               // );
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 8,
//                 crossAxisSpacing: 8,
//                 childAspectRatio: 0.6,
//               ),
//               itemCount: _products.length,
//               itemBuilder: (context, index) {
//                 final product = _products[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => 
//                         ProductDetailPage(
//                           productId: int.parse(product.productId),
//                           productdetail: product),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.all(8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.network(
//                           'https://sntgold.microlanpos.com/${_products[index].productImage}',
//                           height: 150,
//                           fit: BoxFit.fitHeight,
//                         ),
//                         ),
                        
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             product.name,
//                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text('₹${_products[index].sizeWisePrice?.price?.first ?? 'N/A'}',
//                           style: const TextStyle(color: Colors.green)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }


// // Future<void> _fetchProducts() async {
// //     try {
// //       final response = await http.get(
// //         Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
// //         headers: {"Content-Type": "application/json"},
// //       );

// //       if(response.statusCode == 200){
// //         Map<String, dynamic> data = jsonDecode(response.body);
// //         List<dynamic> productsJson = data['product'];
// //         List<dynamic> filteredProducts = productsJson.where((json) {
// //         return json['category'] == '3';  // Filter products where category is '1'
// //       }).toList();

// //       setState(() {
// //         _products = filteredProducts.map((json) => Product.fromJson(json)).toList();
// //         _isLoading = false;
// //       });
// //       } else {
// //         throw Exception("Failed to load products");
// //       }
// //     } catch (e) {
// //       print("Error fetching products: $e");
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }