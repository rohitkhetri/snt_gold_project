import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  List<String> selectedWeights = [];
  List<String> selectedCategories = [];
  List<String> selectedSubcategories = [];
  Map<String, dynamic> filterData = {};
  List<dynamic> filteredProducts = []; // List to hold the filtered products
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchFilterOptions();
  }

  Future<void> fetchFilterOptions() async {
    final response = await http.get(
      Uri.parse('https://sntgold.microlanpos.com/api/filter-product-page'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      setState(() {
        filterData = json.decode(response.body)['for_filter_product_data'];
        isLoading = false; // Stop loading after fetching options
      });
    } else {
      throw Exception('Failed to load filter options');
    }
  }

  Future<void> applyFilters() async {
    final filterRequestData = {
      "brand": selectedBrands,
      "size": selectedSizes,
      "weight": selectedWeights,
      "category": selectedCategories,
      "subcategory": selectedSubcategories,
      "below10000": "10000",
      "10k_20K": "10000-20000",
      "20k_30K": "20000-30000",
      "30k_40K": "30000-40000",
      "40k_50K": "40000-50000",
      "above50000": "50000",
      "sortBy": "atoz",
    };

    final response = await http.post(
      Uri.parse('https://sntgold.microlanpos.com/api/filter-all-product'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(filterRequestData),
    );

    if (response.statusCode == 200) {
      setState(() {
        filteredProducts = json
            .decode(response.body); // Update the list with filtered products
      });
    } else {
      throw Exception('Failed to apply filters');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Filter Products')),
      body: Column(
        children: [
          // Filters
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Categories
                  buildDropdownFilter(
                      'Categories', filterData['category'], selectedCategories),
                  // Subcategories
                  buildDropdownFilter('Subcategories',
                      filterData['subcategory'], selectedSubcategories),
                  // Brands
                  buildDropdownFilter(
                      'Brands', filterData['brand'], selectedBrands),
                  // Sizes
                  buildDropdownFilter(
                      'Sizes', filterData['carat'], selectedSizes),
                  // Weights
                  buildDropdownFilter(
                      'Weights', filterData['weight'], selectedWeights),
                  ElevatedButton(
                    onPressed: applyFilters,
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),
            ),
          ),
          // Display filtered products
          Expanded(
            child: filteredProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        title: Text(product['name'] ?? 'Unnamed Product'),
                        subtitle: Text(
                            'Price: ${product['price'] ?? 'N/A'}'), // Replace with actual price field
                        leading: product['image'] != null
                            ? Image.network(product[
                                'image']) // Replace with actual image field
                            : const Icon(Icons.image_not_supported),
                      );
                    },
                  )
                : const Center(child: Text('No products found')),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownFilter(
      String title, List<dynamic> options, List<String> selectedOptions) {
    return ExpansionTile(
      title: Text(title),
      children: options.map((option) {
        return CheckboxListTile(
          title: Text(option['name'] ?? 'Unknown'),
          value: selectedOptions.contains(option['id'].toString()),
          onChanged: (isSelected) {
            setState(() {
              if (isSelected!) {
                selectedOptions.add(option['id'].toString());
              } else {
                selectedOptions.remove(option['id'].toString());
              }
            });
          },
        );
      }).toList(),
    );
  }
}
