import 'package:flutter/material.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Shop/shopping_products.dart';
import 'package:snt_gold_project/Screens/filter_screen.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilterPage()),
                );
              },
              icon: const Icon(Icons.filter_list)),
          // IconButton(onPressed: () => showSortBottomSheet(context),
          //   icon: const Icon(Icons.sort),
          // ),
        ],
      ),
      body: const ProductGridPage(),
    );
  }
}
