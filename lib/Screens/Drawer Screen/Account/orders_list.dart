import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
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
      // Handle the missing user ID (e.g., show an error or redirect to login).
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
        title: const Text("My Orders"),
      ),
      body: accountData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: accountData!['message']['order_list'].length,
                itemBuilder: (context, index) {
                  final order = accountData!['message']['order_list'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(246, 226, 165, 45),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID: ${order['id']}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Total Amount: ${order['total_amount']}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Status: ${order['order_status']}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to Order Detail Screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailScreen(order: order),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(246, 226, 165, 45),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "View Details",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  Future<void> cancelOrder(BuildContext context) async {
    final url = Uri.parse('https://sntgold.microlanpos.com/api/cancle-order');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final orderDetails = order['order_details'] != null
        ? json.decode(order['order_details'])
        : [];
    final product = orderDetails.isNotEmpty ? orderDetails[0] : null;

    if (product != null && product['productid'] != null) {
      final body = json.encode({
        "order_id": order['id'],
        "cancel_reason": "change product",
        "product_id": product['productid'],
        "product_index": 0,
      });

      try {
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );

        final responseBody = json.decode(response.body);

        if (response.statusCode == 200 && responseBody['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Order canceled successfully.")),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text("Failed to cancel order: ${responseBody['message']}")),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error canceling order.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No valid product found.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> orderDetails = json.decode(order['order_details']);

    // Determine if the order is cancelable based on the order status
    bool isCancelable = order['order_status'] != 'canceled';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: ${order['id']}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Total Amount: ${order['total_amount']}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Status: ${order['order_status']}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text("Product Details:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: orderDetails.length,
                itemBuilder: (context, index) {
                  final product = orderDetails[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(246, 226, 165, 45),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product ID: ${product['productid']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("Price: ${product['price']}",
                                  style: const TextStyle(fontSize: 14)),
                              Text("Size: ${product['size']}",
                                  style: const TextStyle(fontSize: 14)),
                              Text("Quantity: ${product['quantity']}",
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Cancel button based on whether the order is cancelable
            ElevatedButton.icon(
              onPressed: isCancelable ? () => cancelOrder(context) : null,
              icon: const Icon(Icons.cancel),
              label: Text(
                  isCancelable ? "Cancel Order" : "Order Already Canceled"),
              style: ElevatedButton.styleFrom(
                backgroundColor: isCancelable ? Colors.red : Colors.grey,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
