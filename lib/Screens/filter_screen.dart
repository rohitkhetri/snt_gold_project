import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:snt_gold_project/Product_List/all_products.dart'; // Ensure this path is correct

class FilterScreen extends StatefulWidget {
  final List<Product> allProducts;
  final Function(List<Product>) onFiltersApplied;
  const FilterScreen({super.key, required this.allProducts, required this.onFiltersApplied});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> categories = [
    "Price",
    "Brands",
    "Size",
    "Weight",
    "Category",
    "Subcategory"
  ];

  Map<String, List<String>> subcategories = {
    "Price": ["0-10000", "10000 - 20000", "20000 - 30000", "30000 - 40000", "40000 - 50000", "Above 50000"],
    "Brands": ["1"], // Replace with actual brand names
    "Size": ["1","2"], // Replace with actual size options
    "Weight": ["1","2"], // Replace with actual weight options
    "Category": ["3", "2", "1"], // Replace with actual category options
    "Subcategory": ["8", "7", "2", "5", "6", "11", "3", "4", "1"], // Replace with actual subcategory options
  };

  String selectedCategory = "Price"; // Default to Price
  Map<String, Set<String>> selectedSubcategories = {
    "Price": {},
    "Brands": {},
    "Size": {},
    "Weight": {},
    "Category": {},
    "Subcategory": {},
  };

  bool _isLoading = true;

  // Function to apply filters and fetch filtered products
  Future<void> _fetchFilters() async {
    const url = 'https://sntgold.microlanpos.com/api/filter-product-page';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body)['for_filter_product_data'];
        setState(() {
          // Map the response to the subcategories
          subcategories = {
            "Price": jsonData['price'].map<String>((item) => item.toString()).toList(),
            "Brands": jsonData['brand'].map<String>((item) => item['name']).toList(),
            "Size": jsonData['carat'].map<String>((item) => item['name']).toList(),
            "Weight": jsonData['weight'].map<String>((item) => item['name']).toList(),
            "Category": jsonData['category'].map<String>((item) => item['name']).toList(),
            "Subcategory": jsonData['subcategory'].map<String>((item) => item['subcategories']).toList(),
          };
          _isLoading = false; // Set loading to false
        });
      } else {
        throw Exception('Failed to load filters: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false on error
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
    
  }

  void applyFilters() {
    // Implement your filter application logic here
    print("Filters applied: $selectedSubcategories");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView(
                      children: categories.map((category) {
                        return ListTile(
                          title: Text(
                            category,
                            style: TextStyle(
                              fontWeight: selectedCategory == category
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          selected: selectedCategory == category,
                          onTap: () {
                            setState(() {
                              selectedCategory = category; // Update selected category
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ListView(
                      children: subcategories[selectedCategory]!.map((subcategory) {
                        return CheckboxListTile(
                          title: Text(subcategory),
                          value: selectedSubcategories[selectedCategory]!.contains(subcategory),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                selectedSubcategories[selectedCategory]!.add(subcategory);
                              } else {
                                selectedSubcategories[selectedCategory]!.remove(subcategory);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        // Reset all selections
                        selectedSubcategories.forEach((key, value) {
                          value.clear();
                        });
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _fetchFilters();
                      Navigator.pop(context); // Call the apply filters function
                    },
                    child: const Text("Apply Filter"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
