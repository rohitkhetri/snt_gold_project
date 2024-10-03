import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedFilter = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("All Products"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Fliter By:',
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // DropdownButton<String>(
              //     value: selectedFilter,
              //     items: <String>['All']
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //     onChanged: (String? 'Gold') {
              //       setState(() {
              //         selectedFilter = newValue!;
              //         // Add logic to filter products based on the selected filter
              //       });
              //     },
              //   ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ProductCard();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => showSortBottomSheet(context),
              child: const Text('Sort By'),
            ),
          ),
        ],
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
                leading: Radio(value: 1, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                title: const Text('Relevance'),
                leading: Radio(value: 2, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                title: const Text('Discount'),
                leading: Radio(value: 3, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                title: const Text('Price (highest first)'),
                leading: Radio(value: 4, groupValue: 1, onChanged: (value) {}),
              ),
              ListTile(
                title: const Text('What\'s New'),
                leading: Radio(value: 5, groupValue: 1, onChanged: (value) {}),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.black,
                  child: const Text(
                    '30% OFF',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name Goes Here',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹ 25,652',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Women | Diamond Ring',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite, size: 20, color: Colors.grey),
                SizedBox(width: 4),
                Text('4.7K'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
