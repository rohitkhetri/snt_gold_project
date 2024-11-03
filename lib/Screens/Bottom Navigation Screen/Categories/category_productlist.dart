import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatelessWidget {
  final String categoryId;

  const ProductPage({super.key, required this.categoryId});

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if(token != null){

      final response = await http.get(
        Uri.parse('https://sntgold.microlanpos.com/api/product_list'),
        headers: {"Content-Type": "application/json",
        "Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> productsJson = data['product'];

        // Filter products based on the subcategory ID
        List<dynamic> filteredProducts = productsJson.where((json) {
          return json['category'] == categoryId.toString(); // Match category ID
        }).toList();

        return filteredProducts.map((json) => Product.fromJson(json)).toList();
      }} else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      rethrow;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProductsByCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          }

          final products = snapshot.data ?? [];

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.6,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        productId: int.parse(product.productId),
                        productdetail: product,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          
                          buildStarRating(product.productRating?.toDouble() ?? 0.0),

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
          );
        },
      ),
    );
  }
}
