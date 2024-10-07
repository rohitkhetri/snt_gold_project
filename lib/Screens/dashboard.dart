import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snt_gold_project/Screens/cart.dart';
import 'package:snt_gold_project/Model/category_model.dart';
import 'package:snt_gold_project/Screens/favorite.dart';
import 'package:snt_gold_project/Dashboard/products.dart';
import 'package:snt_gold_project/Screens/help_screen.dart';
import 'package:snt_gold_project/Screens/profile_screen.dart';
import 'package:snt_gold_project/Screens/settings_screen.dart';
import 'package:snt_gold_project/Screens/shopping.dart';
import 'package:snt_gold_project/Product_List/new_product.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
  
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(216, 226, 165, 45),
          elevation: 0,
          title: Center(
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(216, 226, 165, 45),
              radius: 18,
              child: Image.asset('assets/snt_logo.png'),
            ),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.search_rounded, color: Colors.black),onPressed: () {},),
            //IconButton(icon: const Icon(Icons.notifications, color: Colors.black),onPressed: () {},),
            IconButton(icon: const Icon(Icons.favorite_border, color: Colors.black),onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen())
              );
            },),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                ),
                child: const Text('Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Orders'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Help'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Policy Terms'),
                onTap: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> const PolicyTerms()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            HomePage(),
            CategoriesPage(),
            ShoppingPage(),
            CartPage1(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black),label: 'Home',),
            BottomNavigationBarItem(icon: Icon(Icons.category, color: Colors.black),label: 'Categories',),
            BottomNavigationBarItem(icon: Icon(Icons.border_all_outlined, color: Colors.black),label: 'Shop',),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.black),label: 'Cart',),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.amber,
                child: Text("R", style: TextStyle(color: Colors.white)),
              ),
              label: 'Raj Kumar',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}

class PolicyTerms extends StatelessWidget{
  const PolicyTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Terms'),
      ),
      body: const Center(child: Text('Policy Terms', style: TextStyle(fontSize: 24),)),
    );
  }
  
 
}


class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Problem'),
      ),
      body: const Center(
        child: Text('Report a Problem form will be displayed here.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}


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
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryItem(label: 'Earrings', assetImage: 'assets/earrings.jpeg'),
                CategoryItem(label: 'Pendants', assetImage: 'assets/pendant.webp'),
                CategoryItem(label: 'Rings', assetImage: 'assets/gold_ring.webp'),
                CategoryItem(label: 'NosePins', assetImage: 'assets/nosepin_gold.png'),
                CategoryItem(label: 'Bracelets', assetImage: 'assets/bracelet1.png'),
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


// class ShoppingPage extends StatelessWidget {
//   const ShoppingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//                 ),
//               ),
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   color: Colors.black,
//                   child: const Text(
//                     '30% OFF',
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Product Name Goes Here',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '₹ 25,652',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 Text(
//                   'Women | Diamond Ring',
//                   style: TextStyle(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(Icons.favorite, size: 20, color: Colors.grey),
//                 SizedBox(width: 4),
//                 Text('4.7K'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Product Image
              Image.asset('assets/ring.jpg',
                width: 80,
                height: 80,
              ),
              const SizedBox(width: 16.0),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gold Necklace",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text("\$1500", style: TextStyle(fontSize: 16, color: Colors.amber[600])),
                  ],
                ),
              ),

              // Quantity Selector
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Decrease quantity
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const Text("1"), // Display quantity
                  IconButton(
                    onPressed: () {
                      // Increase quantity
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              // Remove Button
              IconButton(
                onPressed: () {
                  // Remove item from cart
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Category Item  
class CategoryItem extends StatelessWidget {
  final String label;
  final String assetImage;

  const CategoryItem({super.key, required this.label, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(assetImage, width: 50, height: 50),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Product Category 
class ProductCategory extends StatelessWidget {
  final String label;
  final String assetImage;

  const ProductCategory({super.key, required this.label, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
        );
      },
    child: Column(
      children: [
        Image.asset(assetImage, height: 180, fit: BoxFit.fill),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
    );
  }
}

// Product Item 
class Newproduct extends StatelessWidget {
  final NewProduct product;

  const Newproduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
        );
      },
      child: Container(
        // height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  product.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display product name and price dynamically
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹ ${product.price}',
                    style: const TextStyle(color: Colors.green, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '4.7K likes', // Update with dynamic data if needed
                        style: TextStyle(fontSize: 12),
                      ),
                      Icon(Icons.favorite_border, size: 18),
                    ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}

// Product Item 
class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const ProductsScreen()),
        );
      },
      child :Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/bracelet1.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: const Text(
                    '30% OFF',
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 5),
                Text(
                  '₹ 25,652',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '4.7K likes',
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(Icons.favorite_border, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}