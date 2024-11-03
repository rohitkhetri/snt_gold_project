// import 'package:flutter/material.dart';
// import 'package:snt_gold_project/detaildemo/apiservice.dart';
// import 'package:snt_gold_project/detaildemo/product_class.dart';
// import 'package:snt_gold_project/detaildemo/productdetail.dart';

// class ProductListPage extends StatefulWidget {
//   const ProductListPage({Key? key}) : super(key: key);

//   @override
//   _ProductListPageState createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   late Future<List<Product>> _productList;

//   @override
//   void initState() {
//     super.initState();
//     _productList = ApiService().fetchProducts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: FutureBuilder<List<Product>>(
//         future: _productList,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No products available'));
//           } else {
//             final products = snapshot.data!;

//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text('ID: ${product.productId}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailPage(productId: product.productId),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
