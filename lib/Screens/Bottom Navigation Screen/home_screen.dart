import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snt_gold_project/Product_List/new_product.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/category_product_list2.dart';
import 'package:snt_gold_project/Screens/dashboard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              // child: const TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Search By Product, Brand & More..',
              //     hintStyle: TextStyle(color: Colors.white),
              //     border: InputBorder.none,
              //     icon: Icon(Icons.search, color: Colors.white),
              //   ),
              // ),
            ),
          ),

          // Banner Section
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1.0,
            ),
            items: [
              'assets/banner1.jpeg',
              'assets/banner2.jpeg',
              'assets/banner2.jpeg',
              'assets/banner2.jpeg'
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(215, 163, 120, 33),
                    ),
                    child: Image.asset(
                      i,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),
          // Categories Section
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

                GestureDetector(
    onTap: () {
      // Navigate to the product page with the 'Earrings' id
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductPage(categoryId: '1'),
        ),
      );
    },
    child: const CategoryItem(label: 'Earrings', assetImage: 'assets/earrings.jpeg'),
  ),
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductPage(categoryId: '2'),
        ),
      );
    },
    child: const CategoryItem(label: 'Pendants', assetImage: 'assets/pendant.webp'),
  ),
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductPage(categoryId: '3'),
        ),
      );
    },
    child: const CategoryItem(label: 'Rings', assetImage: 'assets/gold_ring.webp'),
  ),
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductPage(categoryId: '4'),
        ),
      );
    },
    child: const CategoryItem(label: 'NosePins', assetImage: 'assets/nosepin_gold.png'),
  ),
  GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProductPage(categoryId: '5'),
        ),
      );
    },
    child: const CategoryItem(label: 'Bracelets', assetImage: 'assets/bracelet1.png'),
  ),
                // CategoryItem(id: 1,label: 'Earrings', assetImage: 'assets/earrings.jpeg'),
                // CategoryItem(id: 2,label: 'Pendants', assetImage: 'assets/pendant.webp'),
                // CategoryItem(id: 3,label: 'Rings', assetImage: 'assets/gold_ring.webp'),
                // CategoryItem(id: 4,label: 'NosePins', assetImage: 'assets/nosepin_gold.png'),
                // CategoryItem(id: 5,label: 'Bracelets', assetImage: 'assets/bracelet1.png'),
              ],
            ),
          ),

          // Product Photos
          // const Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: ProductCategory(
          //               assetImage: 'assets/ring.jpg',
          //               label: 'Gold Ring',
          //             ),
          //           ),
          //           SizedBox(width: 10),
          //           Expanded(
          //             child: ProductCategory(
          //               assetImage: 'assets/earrings.jpeg',
          //               label: 'Gold Earring',
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 10),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: ProductCategory(
          //               assetImage: 'assets/pendants.jpeg',
          //               label: 'Gold Pendant',
          //             ),
          //           ),
          //           SizedBox(width: 10),
          //           Expanded(
          //             child: ProductCategory(
          //               assetImage: 'assets/necklace.jpeg',
          //               label: 'Gold Chain',
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          // New arrival Section
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'New Arrival',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: allnewproducts.length,
            itemBuilder: (context, index) {
              final product = allnewproducts[index];
              return Newproduct(product: product);
            },
          ),

          // Recently Viewed Section
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Recently Viewed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return const ProductItem();
            },
          ),
        ],
      ),
    );
  }
}

