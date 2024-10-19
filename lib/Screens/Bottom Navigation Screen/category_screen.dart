import 'package:flutter/material.dart';
import 'package:snt_gold_project/Model/category_model.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchBar(),
          ),
          Expanded(
            child: CategoryList(),
          ),
        ],
      ),
    );
  }
}

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Product Categories',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: ProductCategoryPage(),
// //     );
// //   }
// // }

// // class ProductCategoryPage extends StatefulWidget {
// //   @override
// //   _ProductCategoryPageState createState() => _ProductCategoryPageState();
// // }

// // class _ProductCategoryPageState extends State<ProductCategoryPage> {
// //   List<dynamic> productList = [];
// //   Map<String, Map<String, List<dynamic>>> categorizedData = {};

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchProducts();
// //   }

// //   Future<void> fetchProducts() async {
// //     final url = Uri.parse('https://sntgold.microlanpos.com/api/product_list');
// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       setState(() {
// //         productList = json.decode(response.body)['product'];
// //         categorizedData = organizeCategories(productList);
// //       });
// //     } else {
// //       throw Exception('Failed to load products');
// //     }
// //   }

// //   Map<String, Map<String, List<dynamic>>> organizeCategories(List<dynamic> products) {
// //     Map<String, Map<String, List<dynamic>>> categoryMap = {};

// //     for (var product in products) {
// //       String category = product['category'] ?? 'Unknown Category';
// //       String subCategory = product['sub_category'] ?? 'Unknown Subcategory';

// //       // Initialize category if it doesn't exist
// //       if (!categoryMap.containsKey(category)) {
// //         categoryMap[category] = {};
// //       }

// //       // Initialize subcategory under the category
// //       if (!categoryMap[category]!.containsKey(subCategory)) {
// //         categoryMap[category]![subCategory] = [];
// //       }

// //       // Add the product to the subcategory list
// //       categoryMap[category]![subCategory]!.add(product);
// //     }

// //     return categoryMap;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Product Categories'),
// //       ),
// //       body: productList.isEmpty
// //           ? Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //               itemCount: categorizedData.keys.length,
// //               itemBuilder: (context, index) {
// //                 String category = categorizedData.keys.elementAt(index);
// //                 return ExpansionTile(
// //                   title: Text('Category $category'),
// //                   children: categorizedData[category]!.keys.map((subCategory) {
// //                     return ExpansionTile(
// //                       title: Text('Subcategory $subCategory'),
// //                       children: categorizedData[category]![subCategory]!.map<Widget>((product) {
// //                         return ListTile(
// //                           title: Text(product['name'] ?? 'Unnamed Product'),
// //                           subtitle: Text('Price: ${product['size_wise_price']}'),
// //                           trailing: product['product_image'] != null
// //                               ? Image.network(
// //                                   'https://sntgold.microlanpos.com/' + product['product_image'],
// //                                   width: 50,
// //                                   height: 50,
// //                                 )
// //                               : null,
// //                         );
// //                       }).toList(),
// //                     );
// //                   }).toList(),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }