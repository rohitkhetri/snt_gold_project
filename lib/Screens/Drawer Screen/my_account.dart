import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccount> {
  Map<String, dynamic>? accountData;
  int? userId;

  @override
  void initState() {
    super.initState();
    loadUserIdAndFetchData();
    // fetchAccountData();
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
    final body = json.encode({
      'user_id': userId,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          accountData = json.decode(response.body);
        });
      } else {
        print('Failed to load account data: ${response.statusCode}');
        print('Headers: ${response.headers}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
      ),
      body: accountData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "User Details:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      "Name: ${accountData!['message']['user_detail'][0]['name']}"),
                  Text(
                      "Email: ${accountData!['message']['user_detail'][0]['email']}"),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
