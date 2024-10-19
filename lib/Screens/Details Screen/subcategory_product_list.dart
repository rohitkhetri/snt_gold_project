import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/product_detail.dart';

class CategoryProductList extends StatelessWidget {
  final String category;
  final String subcategory;
  final List<Product> products;

  const CategoryProductList({
    super.key,
    required this.category,
    required this.subcategory,
    required this.products, required String categoryId,
  });

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory Products'),
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
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                          'https://sntgold.microlanpos.com/${products[index].productImage}',
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
                          child: Text('₹${products[index].sizeWisePrice?.price?.first ?? 'N/A'}',
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