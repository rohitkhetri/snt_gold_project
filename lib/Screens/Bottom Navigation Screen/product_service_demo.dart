import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Product_List/sizeweight.dart';

class ProductService {
  static Future<ProductDetail> fetchProductDetails(int productId) async {
    final url = Uri.parse('https://sntgold.microlanpos.com/api/product-detail/$productId');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ProductDetail.fromJson(data);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      print('Error fetching product details: $e');
      throw Exception('Error fetching product details');
    }
  }
}
