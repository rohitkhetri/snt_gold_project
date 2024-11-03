import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart'; // Import the ProductDetailPage

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token != null) {
        final response = await http.get(
          Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          List<dynamic> productsJson = data['product'];
          setState(() {
            allProducts =
                productsJson.map((json) => Product.fromJson(json)).toList();
            _isLoading = false;
          });
        }
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

  void searchProducts(String query) {
    final results = allProducts
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredProducts = results;
    });
  }

  void onSearchPressed() {
    searchProducts(query);
  }

  void onProductTap(Product product) {
    // Navigate to the ProductDetailPage and pass the selected product
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProductDetailPage(productdetail: product, productId: product.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search_rounded, color: Colors.black),
                  onPressed: onSearchPressed,
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredProducts.isEmpty
              ? const Center(child: Text('No products found.'))
              : ListView.builder(
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ListTile(
                      title: Text(product.name),
                      onTap: () => onProductTap(product), // Handle product tap
                    );
                  },
                ),
    );
  }
}
