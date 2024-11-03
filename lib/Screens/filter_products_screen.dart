import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snt_gold_project/Model/star_rating.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';

class FilteredProductsPage extends StatefulWidget {
  final Map<String, String?> filters;

  const FilteredProductsPage({super.key, required this.filters});

  @override
  _FilteredProductsPageState createState() => _FilteredProductsPageState();
}

class _FilteredProductsPageState extends State<FilteredProductsPage> {
  List<Product> filteredProducts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchFilteredProducts();
  }

  Future<void> fetchFilteredProducts() async {
    setState(() {
      isLoading = true; // Start loading
    });

    const url = 'https://sntgold.microlanpos.com/api/filter-all-product';
    final headers = {'Content-Type': 'application/json'};

    final body = json.encode({
      "below10000": widget.filters["below10000"],
      "10k_20K": widget.filters["10k_20K"],
      // Add other filters here
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse['products'];

        setState(() {
          filteredProducts =
              jsonData.map((product) => Product.fromJson(product)).toList();
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error'); // Log any errors
    } finally {
      setState(() {
        isLoading = false; // End loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filtered Products')),
      body: isLoading
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
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
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
                              color: Color(0xFFE4B062),
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
}
