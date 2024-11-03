import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Product_List/new_product.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Cart/cart_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Categories/category_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Home%20Screen/home_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Profile%20Screens/profile_screen.dart';
import 'package:snt_gold_project/Screens/Bottom%20Navigation%20Screen/Shop/shop.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/newProduct_Detailpage.dart';
import 'package:snt_gold_project/Screens/Details%20Screen/wishlist_page.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/Account/account_page.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/Account/orders_list.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/about_us_screen.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/help_screen.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/policy_terms_screens.dart';
import 'package:snt_gold_project/Screens/login_screen.dart';
import 'package:snt_gold_project/Screens/search_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  String? userEmail;
  String? _userId;
  bool _isLoadingUserId = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fetchUserId();
    // _getEmail();
  }

  // Future<void> fetchUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     userId = prefs.getString('userId');
  //     print('Fetched username: $userId');

  //   });
  // }
// Future<String?> _getEmail() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('email'); // Retrieve the email from SharedPreferences
//   }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdInt = prefs.getInt('user_id') ??
        int.tryParse(prefs.getString('user_id') ?? '');
    userEmail = prefs.getString('email'); // Fetch the email

    if (userIdInt != null) {
      setState(() {
        _userId = userIdInt.toString(); // Convert int to String
        _isLoadingUserId = false;
      });
      // await _fetchAddressList();
    } else {
      setState(() {
        // _error = 'User ID not found';
        _isLoadingUserId = false;
      });
    }
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
            IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
            ),
            //IconButton(icon: const Icon(Icons.notifications, color: Colors.black),onPressed: () {},),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WishlistPage()));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(216, 226, 165, 45),
                      Colors.amberAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          child: Text(
                            userEmail != null && userEmail!.isNotEmpty
                                ? userEmail![0].toUpperCase()
                                : 'U', // First letter of email or 'U' if email is unavailable
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Welcome!!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.black87),
                        const SizedBox(width: 10),
                        Text(
                          userEmail ?? "Email not available",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black26,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Image.asset('assets/package.png', height: 25),
                title: const Text('Orders'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyOrder()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_box),
                title: const Text('My Account'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('About Us'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Policy Terms'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PolicyTerms()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  _logout(context);
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
          children: [
            const HomePage(),
            const CategoriesPage(),
            // CategoriesPage(),
            const ShoppingPage(),
            // ProductDetailPage(productId: 0),
            // MyApp(),
            const CartPageDemo1(),
            // CartPage1(),
            ProfileScreen(userName: 'Guest'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.amber : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/menu.png',
                height: 25,
                color: _selectedIndex == 1 ? Colors.amber : Colors.grey,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/online-shopping.png',
                height: 25,
                color: _selectedIndex == 2 ? Colors.amber : Colors.grey,
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: _selectedIndex == 3 ? Colors.amber : Colors.grey,
                  ),
                  // if (_cartItemCount > 0)
                  //   Positioned(
                  //     top: -5,
                  //     right: -10,
                  //     child: Container(
                  //       padding: const EdgeInsets.all(2),
                  //       decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       constraints: const BoxConstraints(
                  //         minWidth: 18,
                  //         minHeight: 18,
                  //       ),
                  //       child: Text(
                  //         '$_cartItemCount',
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 16,
                backgroundColor:
                    _selectedIndex == 4 ? Colors.amber : Colors.grey,
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Text(
                    "R",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              label: 'Raj Kumar',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          elevation: 8,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          iconSize: 26,
          // Adding a visual indicator (underline) for selected item
          selectedIconTheme: const IconThemeData(size: 30),
        ),
      ),
    );
  }
}

Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');

  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}

// Category Item
class CategoryItem extends StatelessWidget {
  // final String id;
  final String label;
  final String assetImage;

  const CategoryItem(
      {super.key, required this.label, required this.assetImage});

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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  newProduct_DetailPage(newproductdetail: product)),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
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
      child: Container(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
