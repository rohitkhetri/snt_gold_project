
// Example page for subcategory details
import 'package:flutter/material.dart';

class SubcategoryDetailPage extends StatelessWidget {
  final String category;
  final String subcategory;

  const SubcategoryDetailPage({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory - $category'),
      ),
      body: Center(
        child: Text(
          'Details for $subcategory in $category',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}