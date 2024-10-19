import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Product_List/all_products.dart'; // Adjust import paths as necessary
// import 'package:snt_gold_project/Screens/filter_screen.dart'; // Adjust import paths as necessary
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart'; // Adjust import paths as necessary

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  // final int _selectedSortOption = 1;
  List<Product> _products = [];
  // List<Product> _displayedProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products initially
    
  }

  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
        headers: {"Content-Type": "application/json"},
      );

      if(response.statusCode == 200){
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> productsJson = data['product'];
        setState(() {
          _products = productsJson.map((json) => Product.fromJson(json)).toList();
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

  // Function to update displayed products based on applied filters 
  // void _updateProducts(List<Product> filteredProducts) {
  //   setState(() {
  //     _displayedProducts = filteredProducts; // Update displayed products
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Navigate to filter screen and pass current products
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FilterScreen(
              //       allProducts: _fetchProducts,
              //       // onFiltersApplied: _updateProducts, // Pass function to handle applied filters
              //     ),
                // ),
              // );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        ProductDetailPage(
                          productId: int.parse(product.productId),
                          productdetail: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://sntgold.microlanpos.com/${_products[index].productImage}',
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('₹${_products[index].sizeWisePrice?.price?.first ?? 'N/A'}',
                          style: const TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}


// Future<void> _fetchProducts() async {
//     try {
//       final response = await http.get(
//         Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
//         headers: {"Content-Type": "application/json"},
//       );

//       if(response.statusCode == 200){
//         Map<String, dynamic> data = jsonDecode(response.body);
//         List<dynamic> productsJson = data['product'];
//         List<dynamic> filteredProducts = productsJson.where((json) {
//         return json['category'] == '3';  // Filter products where category is '1'
//       }).toList();

//       setState(() {
//         _products = filteredProducts.map((json) => Product.fromJson(json)).toList();
//         _isLoading = false;
//       });
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