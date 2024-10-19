// import 'package:flutter/material.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({super.key});

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   // Define the filter criteria
//   String below10000 = "10000";
//   String tenToTwentyK = "10000-20000";
//   String twentyToThirtyK = "20000-30000";
//   String thirtyToFortyK = "30000-40000";
//   String fortyToFiftyK = "40000-50000";
//   String aboveFiftyK = "50000";

//   List<String> selectedBrands = [];
//   List<String> selectedSizes = [];
//   List<String> selectedWeights = [];
//   List<String> selectedCategories = [];
//   List<String> selectedSubcategories = [];

//   // Apply filters and return them
//   void applyFilters(BuildContext context) {
//     final filters = {
//       "below10000": below10000,
//       "10k_20K": tenToTwentyK,
//       "20k_30K": twentyToThirtyK,
//       "30k_40K": thirtyToFortyK,
//       "40k_50K": fortyToFiftyK,
//       "above50000": aboveFiftyK,
//       "brand": selectedBrands,
//       "size": selectedSizes,
//       "weight": selectedWeights,
//       "category": selectedCategories,
//       "subcategory": selectedSubcategories,
//       "sortBy": "atoz"
//     };

//     Navigator.pop(context, filters);
//   }

//   // Build the filter UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Filter Products'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Price Range
//             const Text('Price Range', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             ListTile(
//               title: const Text('Below 10,000'),
//               leading: Radio(
//                 value: below10000,
//                 groupValue: below10000,
//                 onChanged: (value) {
//                   setState(() {
//                     below10000 = value as String;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text('10,000 - 20,000'),
//               leading: Radio(
//                 value: tenToTwentyK,
//                 groupValue: below10000,
//                 onChanged: (value) {
//                   setState(() {
//                     below10000 = value as String;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text('20,000 - 30,000'),
//               leading: Radio(
//                 value: twentyToThirtyK,
//                 groupValue: below10000,
//                 onChanged: (value) {
//                   setState(() {
//                     below10000 = value as String;
//                   });
//                 },
//               ),
//             ),
//             // Add more price range options...

//             const SizedBox(height: 20),
//             // Brand Selection
//             const Text('Brands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Brand 1'),
//               value: selectedBrands.contains('1'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedBrands.add('1');
//                   } else {
//                     selectedBrands.remove('1');
//                   }
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Brand 2'),
//               value: selectedBrands.contains('2'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedBrands.add('2');
//                   } else {
//                     selectedBrands.remove('2');
//                   }
//                 });
//               },
//             ),
//             // Add more brand options...

//             const SizedBox(height: 20),
//             // Size Selection
//             const Text('Sizes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Size 1'),
//               value: selectedSizes.contains('1'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedSizes.add('1');
//                   } else {
//                     selectedSizes.remove('1');
//                   }
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Size 2'),
//               value: selectedSizes.contains('2'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedSizes.add('2');
//                   } else {
//                     selectedSizes.remove('2');
//                   }
//                 });
//               },
//             ),
//             // Add more size options...

//             const SizedBox(height: 20),
//             // Weight Selection
//             const Text('Weights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Weight 1'),
//               value: selectedWeights.contains('1'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedWeights.add('1');
//                   } else {
//                     selectedWeights.remove('1');
//                   }
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Weight 2'),
//               value: selectedWeights.contains('2'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedWeights.add('2');
//                   } else {
//                     selectedWeights.remove('2');
//                   }
//                 });
//               },
//             ),
//             // Add more weight options...

//             const SizedBox(height: 20),
//             // Category Selection
//             const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Category 1'),
//               value: selectedCategories.contains('1'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedCategories.add('1');
//                   } else {
//                     selectedCategories.remove('1');
//                   }
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Category 2'),
//               value: selectedCategories.contains('2'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedCategories.add('2');
//                   } else {
//                     selectedCategories.remove('2');
//                   }
//                 });
//               },
//             ),
//             // Add more category options...

//             const SizedBox(height: 20),
//             // Subcategory Selection
//             const Text('Subcategories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             CheckboxListTile(
//               title: const Text('Subcategory 1'),
//               value: selectedSubcategories.contains('1'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedSubcategories.add('1');
//                   } else {
//                     selectedSubcategories.remove('1');
//                   }
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: const Text('Subcategory 2'),
//               value: selectedSubcategories.contains('2'),
//               onChanged: (value) {
//                 setState(() {
//                   if (value == true) {
//                     selectedSubcategories.add('2');
//                   } else {
//                     selectedSubcategories.remove('2');
//                   }
//                 });
//               },
//             ),
//             // Add more subcategory options...

//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => applyFilters(context),
//               child: const Text('Apply Filters'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
