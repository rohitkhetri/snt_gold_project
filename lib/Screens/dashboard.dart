import 'package:flutter/material.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/cart.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/category_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/home_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/shopping.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/policy_terms_screens.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/help_screen.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/newProduct_Detailpage.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/profile_screen.dart';
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const FavoriteScreen())
              // );
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
          children: const  [
            HomePage(),
            CategoriesPage(),
            // CategoriesPage(),
            ShoppingPage(),
            // ProductDetailPage(productId: 0),
            // MyApp(),
            CartPage(cartItems: [],),
            // CartPage1(),
            ProfileScreen(userName: 'Guest'),
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

// Category Item  
class CategoryItem extends StatelessWidget {
  // final String id;
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
// class ProductCategory extends StatelessWidget {
//   final String label;
//   final String assetImage;

//   const ProductCategory({super.key, required this.label, required this.assetImage});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, 
//         MaterialPageRoute(builder: (context) => const ProductsScreen()),
//         );
//       },
//     child: Column(
//       children: [
//         Image.asset(assetImage, height: 180, fit: BoxFit.fill),
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//       ],
//     ),
//     );
//   }
// }

// Product Item 
class Newproduct extends StatelessWidget {
  final NewProduct product;

  const Newproduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => newProduct_DetailPage(newproductdetail: product)),
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
        Navigator.pop(context, 
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