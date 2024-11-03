import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';

Future<void> filterProducts(ProductFilterRequest filterRequest) async {
  const url = 'https://sntgold.microlanpos.com/api/filter-all-product';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(filterRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Handle the response and display filtered products
      print(responseData);
    } else {
      print('Failed to load filtered products: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

Future<void> getProductFilterPage() async {
  const url = 'https://sntgold.microlanpos.com/api/filter-product-page';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Use the response data to show filter page details
      print(responseData);
    } else {
      print('Failed to load filter page: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
