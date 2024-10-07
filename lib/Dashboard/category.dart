// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/Dashboard/category_model.dart';
// import 'package:snt_gold_project/Dashboard/expansion_category.dart';
// import 'package:snt_gold_project/Dashboard/search_form.dart';

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(padding: EdgeInsets.all(16.0),
//             child: SearchForm(),
//             ),
//           Padding(padding: const EdgeInsets.symmetric(
//             horizontal: 16.0, vertical: 16.0/2),
//             child: Text(
//               "Categories",
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//           ),

//           Expanded(
//               child: ListView.builder(
//                 itemCount: demoCategories.length,
//                 itemBuilder: (context, index) => ExpansionCategory(
//                   svgSrc: demoCategories[index].svgSrc!,
//                   title: demoCategories[index].title,
//                   subCategory: demoCategories[index].subCategories!,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }