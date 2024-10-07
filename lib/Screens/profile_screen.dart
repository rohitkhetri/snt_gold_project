import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50, // Profile image size
                    backgroundImage: AssetImage('assets/snt_logo.png'), // Replace with your image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rohit Khetri', // Replace
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Gold | Jewelry', // User bio
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
                // Navigate to orders screen
              },
            ),
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
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTile(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
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
