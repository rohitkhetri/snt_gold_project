
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // List of main categories for the left side
  final List<String> categories = [
    "Price",
    "Brands",
    "Occasion",
    "Discount"
  ];

  // Subcategories for each main category
  Map<String, List<String>> subcategories = {
    "Price": ["Under 1000", "1000 - 5000", "Above 5000"],
    "Brands": ["Tanishq", "Reliance Jewels", "CaratLane", "BlueStone", "Kalyan Jewellers"],
    "Occasion": ["Wedding", "Casual", "Party"],
    "Discount": ["10% Off", "20% Off", "30% Off"],
  };

  // Keep track of the selected category
  String selectedCategory = "Price"; // Default to Price

  // Keep track of selected subcategories (can be different for each category)
  Map<String, Set<String>> selectedSubcategories = {
    "Price": {},
    "Brands": {},
    "Occasion": {},
    "Discount": {},
  };

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
            // Top Section: Filters (Left and Right panels)
            Expanded(
              child: Row(
                children: [
                  // Left side: List of main categories
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

                  // Right side: List of subcategories based on selected category
                  Expanded(
                    flex: 5,
                    child: ListView(
                      children: subcategories[selectedCategory]!.map((subcategory) {
                        return CheckboxListTile(
                          title: Text(subcategory),
                          value: selectedSubcategories[selectedCategory]!
                              .contains(subcategory),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                selectedSubcategories[selectedCategory]!
                                    .add(subcategory);
                              } else {
                                selectedSubcategories[selectedCategory]!
                                    .remove(subcategory);
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

            // Bottom Section: Reset and Apply Filter Buttons
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
                      // Apply the filter logic here (use selectedSubcategories for this)
                      //print(selectedSubcategories);
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