import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:snt_gold_project/Screens/Drawer%20Screen/Account/orders_list.dart';
import 'package:snt_gold_project/Screens/Drawer%20Screen/my_account.dart';
import 'package:snt_gold_project/demo/addressListsccreen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<AccountPage> {
  Map<String, dynamic>? accountData;
  int? userId;

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchData();
  }

  Future<void> loadUserIdAndFetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');

    if (userId != null) {
      await fetchAccountData(userId!);
    } else {
      print("User ID not found. Redirect to login or show error.");
    }
  }

  Future<void> fetchAccountData(int userId) async {
    final url = Uri.parse('https://sntgold.microlanpos.com/api/my-account');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'user_id': userId.toString(),
    };
    final body = json.encode({'user_id': userId});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        setState(() {
          accountData = json.decode(response.body);
        });
      } else {
        print('Failed to load account data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User Info Section
          // _buildUserInfoSection(),
          // const SizedBox(height: 20),
          // const Text('Settings & Options',
          // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          // const SizedBox(height: 10),
          _buildHelpOption(
            context,
            title: 'Dashboard',
            icon: Icons.dashboard,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'My Account',
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyAccount()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'Address',
            icon: Icons.location_on,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddressListScreen()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'Orders',
            icon: Icons.shopping_bag,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyOrder()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Welcome, User!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('user@example.com',
                style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add action for edit profile
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpOption(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

// Placeholder for FAQ Screen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoad'),
      ),
      body: const Center(
        child: Text('DashBoard Loading..', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
