import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Product_List/all_products.dart';

class ApiService {
  static const String baseUrl = "https://sntgold.microlanpos.com/api";

  // Fetch product list
  Future<List<Product>> fetchProductList() async {
    final response = await http.get(
      Uri.parse('$baseUrl/product_list'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> productsJson = data['product'];
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  // Filter products
  Future<List<dynamic>> filterProducts(Map<String, dynamic> filterData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/filter-all-product'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(filterData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to filter products");
    }
  }

  // Fetch product detail
  Future<Map<String, dynamic>> fetchProductDetail(int productId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/product-detail/$productId'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load product detail");
    }
  }

  // Check product availability
  Future<Map<String, dynamic>> checkProductAvailability(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/check-product-availability'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to check product availability");
    }
  }

  // Add product to cart
  Future<void> addProductToCart(Map<String, dynamic> cartData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-product-in-cart'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(cartData),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add product to cart");
    }
  }

  // Fetch wishlist
  Future<List<dynamic>> fetchWishlist(Map<String, dynamic> wishlistData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/wishlist'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(wishlistData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load wishlist");
    }
  }
}
