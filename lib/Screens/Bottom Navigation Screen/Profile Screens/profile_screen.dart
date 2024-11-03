import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/Account/orders_list.dart';
import 'package:snt_gold_project/Screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  ProfileScreen({super.key, required this.userName});

  Map<String, dynamic>? _selectedAddress;
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image and Name
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50, // Profile image size
                    backgroundImage: AssetImage(
                        'assets/snt_logo.png'), // Replace with your image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Gold Silver | Jewelry', // User bio
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Orders Section
            _buildSectionTile(
              context,
              title: 'My Orders',
              icon: Icons.shopping_basket,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrder()));
                // Navigate to orders screen
              },
            ),
            // const Divider(height: 30),
            // More Section
            // _buildSectionTile(
            //   context,
            //   title: 'My Account',
            //   icon: Icons.more_horiz,
            //   onTap: () {
            //     Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => AccountPage(
            //   selectedAddress: _selectedAddress,
            //   products: Provider.of<CartProvider>(context, listen: false).cartItems.map((item) {
            //     return {
            //       'name': item.name,
            //       'price': item.sizeWisePrice,
            //       'quantity': item.quantity,
            //     };
            //   }).toList(),
            //   paymentMethod: _selectedPaymentMethod,
            //     ),
            //     ),
            //     );
            //   },
            // ),
            const Divider(height: 30),
            // More Section
            _buildSectionTile(
              context,
              title: 'More',
              icon: Icons.more_horiz,
              onTap: () {
                // Navigate to more options screen
              },
            ),
            const Divider(height: 30),
            // Logout Section
            _buildSectionTile(
              context,
              title: 'Logout',
              icon: Icons.logout,
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Widget _buildSectionTile(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
