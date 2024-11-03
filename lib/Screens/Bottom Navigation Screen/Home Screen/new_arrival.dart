// new_arrivals_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';

class NewArrivalsPage extends StatefulWidget {
  const NewArrivalsPage({super.key});

  @override
  _NewArrivalsPageState createState() => _NewArrivalsPageState();
}

class _NewArrivalsPageState extends State<NewArrivalsPage> {
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');
      if (token != null) {
        final response = await http.get(
          Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);
          List<dynamic> productsJson = data['product'];
          setState(() {
            // Only take the first 2 products
            _products = productsJson
                .map((json) => Product.fromJson(json))
                .take(2)
                .toList();
            _isLoading = false;
          });
        }
      } else {
        throw Exception("No Token found");
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Displaying the first product if available
                  if (_products.isNotEmpty)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                productId: int.parse(_products[0].productId),
                                productdetail: _products[0],
                              ),
                            ),
                          );
                        },
                        child: _buildProductCard(_products[0]),
                      ),
                    ),
                  // Displaying the second product if available
                  if (_products.length > 1)
                    const SizedBox(
                        width: 8), // Add some space between the products
                  if (_products.length > 1)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                productId: int.parse(_products[1].productId),
                                productdetail: _products[1],
                              ),
                            ),
                          );
                        },
                        child: _buildProductCard(_products[1]),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  // A method to build product card
  Widget _buildProductCard(Product product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '₹${product.sizeWisePrice?.price?.first ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          buildStarRating(product.productRating?.toDouble() ?? 0.0),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
