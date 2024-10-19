
import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';

class ProductListPage extends StatelessWidget {
  final String category;
  final String subcategory;
  final List<Product> products;

  const ProductListPage({
    super.key,
    required this.category,
    required this.subcategory,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory - $category'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network('https://sntgold.microlanpos.com/${products[index].productImage}'), // Dynamic image loading
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].sizeWisePrice.toString()}'),
            onTap: () {
              // Optionally navigate to product detail page
            },
          );
        },
      ),
    );
  }
}
