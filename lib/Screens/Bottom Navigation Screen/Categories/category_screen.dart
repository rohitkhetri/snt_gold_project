import 'package:flutter/material.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Categories/category_list.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            // child: SearchBar(),
          ),
          Expanded(
            child: CategoryList(),
          ),
        ],
      ),
    );
  }
}
