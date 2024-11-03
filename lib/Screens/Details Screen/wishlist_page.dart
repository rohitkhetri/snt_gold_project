import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<int> favoriteProductIds = [];
  List<dynamic> wishlistProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavoriteProductIds();
  }

  Future<void> loadFavoriteProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    // Filter only keys that start with "favorite_"
    final ids = keys
        .where((key) => key.startsWith('favorite_'))
        .map((key) => prefs.getInt(key))
        .whereType<int>()
        .toList();

    setState(() {
      favoriteProductIds = ids;
    });

    if (favoriteProductIds.isNotEmpty) {
      await fetchWishlistProducts();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchWishlistProducts() async {
    final url = Uri.parse('https://sntgold.microlanpos.com/api/wishlist');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "wishlist": favoriteProductIds,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        wishlistProducts = data['data'];
        isLoading = false;
      });
    } else {
      print('Failed to load wishlist products');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> removeFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('favorite_$productId');
    await loadFavoriteProductIds(); // Refresh list

    // After loading, check if the favoriteProductIds is empty
    if (favoriteProductIds.isEmpty) {
      setState(() {
        isLoading = false; // Stop the loading indicator
      });
    }
  }

  // Updated method to accept the product object
  void navigateToProductDetail(dynamic product) {
    // Ensure product_id is valid before parsing
    final productIdString =
        product['product_id']?.toString(); // Get product_id as string
    if (productIdString != null && productIdString.isNotEmpty) {
      // Navigate to Product Detail Page with productId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            productId: int.parse(productIdString), // Convert safely
            productdetail: product, // Pass the product object directly
          ),
        ),
      );
    } else {
      // Handle the case where productId is null or empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid product ID.')),
      );
    }
  }

  Future<void> confirmDelete(int productId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text(
            'Are you sure you want to remove this item from the wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      await removeFavorite(productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishlistProducts.isEmpty
              ? const Center(child: Text('No items in wishlist'))
              : ListView.builder(
                  itemCount: wishlistProducts.length,
                  itemBuilder: (context, index) {
                    final product = wishlistProducts[index];
                    final productId = favoriteProductIds[index];

                    return ListTile(
                      leading: Image.network(
                        'https://sntgold.microlanpos.com/${product['product_image']}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product['product_name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${product['price']}'),
                          Text('Stock Status: ${product['stock_status']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => confirmDelete(productId),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () => navigateToProductDetail(
                                product), // Pass the product object here
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
