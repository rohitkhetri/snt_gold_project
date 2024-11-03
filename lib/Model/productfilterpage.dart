import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductFilterPage extends StatefulWidget {
  const ProductFilterPage({super.key});

  @override
  _ProductFilterPageState createState() => _ProductFilterPageState();
}

class _ProductFilterPageState extends State<ProductFilterPage> {
  // Define your filter options
  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  List<String> selectedWeights = [];
  List<String> selectedCategories = [];
  List<String> selectedSubcategories = [];

  // Sample data for filter options (replace with actual data)
  List<String> brands = ['1', '2', '3'];
  List<String> sizes = ['1', '2'];
  List<String> weights = ['1', '2'];
  List<String> categories = ['1', '2', '3'];
  List<String> subcategories = ['1', '2', '3', '4', '5', '6', '7  '];

  // Method to apply filters
  Future<void> applyFilters() async {
    const url = 'https://sntgold.microlanpos.com/api/filter-all-product';
    final headers = {
      'Content-Type': 'application/json',
    };

    final data = {
      "below10000": "10000",
      "10k_20K": "10000-20000",
      "20k_30K": "20000-30000",
      "30k_40K": "30000-40000",
      "40k_50K": "40000-50000",
      "above50000": "50000",
      "brand": selectedBrands,
      "size": selectedSizes,
      "weight": selectedWeights,
      "category": selectedCategories,
      "subcategory": selectedSubcategories,
      "sortBy": "atoz",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        final responseData = json.decode(response.body);

        // Check if the response contains a 'data' field that is a list
        if (responseData['status'] == 'success' &&
            responseData['data'] is List) {
          List products = responseData['data'];

          // Navigate to the FilteredProductsPage with the products
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilteredProductsPage(products: products),
            ),
          );
        } else {
          // Handle unexpected response structure
          throw Exception('Unexpected response structure');
        }
      } else {
        // Handle error response
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error applying filters: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Brand Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Brand'),
              items: brands.map((brand) {
                return DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !selectedBrands.contains(value)) {
                  setState(() {
                    selectedBrands.add(value);
                  });
                }
              },
            ),
            // Size Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Size'),
              items: sizes.map((size) {
                return DropdownMenuItem(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !selectedSizes.contains(value)) {
                  setState(() {
                    selectedSizes.add(value);
                  });
                }
              },
            ),
            // Weight Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Weight'),
              items: weights.map((weight) {
                return DropdownMenuItem(
                  value: weight,
                  child: Text(weight),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !selectedWeights.contains(value)) {
                  setState(() {
                    selectedWeights.add(value);
                  });
                }
              },
            ),
            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !selectedCategories.contains(value)) {
                  setState(() {
                    selectedCategories.add(value);
                  });
                }
              },
            ),
            // Subcategory Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Subcategory'),
              items: subcategories.map((subcategory) {
                return DropdownMenuItem(
                  value: subcategory,
                  child: Text(subcategory),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null && !selectedSubcategories.contains(value)) {
                  setState(() {
                    selectedSubcategories.add(value);
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: applyFilters,
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

class FilteredProductsPage extends StatelessWidget {
  final List products;

  const FilteredProductsPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Products'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]['name'] ?? 'Unnamed Product'),
            subtitle: Text('Price: ${products[index]['price'] ?? 'N/A'}'),
          );
        },
      ),
    );
  }
}
