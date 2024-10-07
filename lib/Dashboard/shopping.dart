import 'package:flutter/material.dart';
import 'package:snt_gold_project/Model/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Product_List/all_products.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
_ShoppingPageState createState() => _ShoppingPageState();

}

class _ShoppingPageState extends State<ShoppingPage> {
  int _selectedSortOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Gold Jewellery || 0% off on M..."),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FilterScreen()),);
          },
          icon: const Icon(Icons.filter_list)),
          IconButton(onPressed: () => showSortBottomSheet(context),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
            // Additional content can go here
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7, // Adjust to fit your design
              ),
              itemCount: allProducts.length, // The number of jewelry items
              shrinkWrap: true, // Use shrinkWrap to prevent size issues
              physics: const NeverScrollableScrollPhysics(), // Disable GridView scrolling
              itemBuilder: (context, index) {
                final product = allProducts[index];
                return Center(
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              product.imageUrl,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Positioned(
                            //   top: 8,
                            //   left: 8,
                            //   child: Container(
                            //     color: Colors.amber,
                            //     child: const Text("PURE GOLD"),
                            //   ),
                            // ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "₹${product.price}",
                          style: const TextStyle(
                            color: Colors.redAccent,
                          ),
                          )
                          
                        ),
                        const Spacer(), // Pushes the button to the bottom
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity, // Full width button
                            child: TextButton(
                              onPressed: () {
                                // Add to Cart
                                Provider.of<CartModel>(context, listen: false).addItem({
                                  "name": product.name,
                                  "price": product.price,
                                  "image": product.imageUrl,
                                  "quantity": 1,
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 182, 148, 45),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(10),
                                
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text("Add To Cart"),
                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Price (lowest first)'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Relevance'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Discount'),
                leading: Radio<int>(
                  value: 3,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Price (highest first)'),
                leading: Radio<int>(
                  value: 4,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('What\'s New'),
                leading: Radio<int>(
                  value: 5,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedSortOption = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


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