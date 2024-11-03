import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Product_List/all_product_modelclass.dart';
import 'package:snt_gold_project/Provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;
  final Dio _dio = Dio();
  String? _userId;
  bool _isLoadingUserId = true;

  List<dynamic> _addressList = [];
  bool _isLoading = true;
  String? _error;

  // Variable to hold selected address
  Map<String, dynamic>? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdInt = prefs.getInt('user_id') ??
        int.tryParse(prefs.getString('user_id') ?? '');

    if (userIdInt != null) {
      setState(() {
        _userId = userIdInt.toString(); // Convert int to String
        _isLoadingUserId = false;
      });
      await _fetchAddressList();
    } else {
      setState(() {
        _error = 'User ID not found';
        _isLoadingUserId = false;
      });
    }
  }

  Future<void> _fetchAddressList() async {
    const String url = 'http://sntgold.microlanpos.com/api/address-list';

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        queryParameters: {'user_id': _userId},
      );

      if (response.statusCode == 200) {
        if (response.data != null && response.data['message'] is List) {
          setState(() {
            _addressList = response.data['message'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'No addresses found';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Failed to fetch addresses: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  // double _calculateTotalAmount(List<Product> cartItems) {
  //   return cartItems.fold(0.0, (double sum, Product item) {
  //     // Check for price as a List and cast it correctly
  //     Object price = (item.sizeWisePrice?.price?.first ?? 0.0) is double
  //         ? item.sizeWisePrice!.price!.first
  //         : (item.sizeWisePrice!.price!.first as num).toDouble();

  //     int quantity = item.quantity ?? 1;

  //     return sum + (price * quantity); // Multiplication is now valid
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color.fromARGB(255, 134, 110, 39),
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  _buildAddressList(),
                  const Divider(),
                  _buildPaymentMethodSection(),
                  const Divider(),
                  _buildCartItems(cartItems),
                  const Divider(),
                  // _buildFinalAmount(cartItems), // Display the final amount here
                  const Divider(),
                ],
              ),
            ),
      bottomNavigationBar: _buildCheckoutButton(cartProvider, cartItems),
    );
  }

  Widget _buildCheckoutButton(
      CartProvider cartProvider, List<Product> cartItems) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _handleCheckout(cartProvider, cartItems),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 134, 110, 39),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Proceed to Payment', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<void> _handleCheckout(
      CartProvider cartProvider, List<Product> cartItems) async {
    if (_selectedPaymentMethod != null && _selectedAddress != null) {
      if (_userId != null) {
        try {
          // Construct product data for the API
          final Map<String, dynamic> productData = {};
          for (var item in cartItems) {
            // Skip invalid items
            if (item.quantity! <= 0) continue;

            // Construct product data
            productData[item.productId.toString()] = {
              'quantity': item.quantity ?? 1,
              'product_index': cartItems.indexOf(item),
              'size': item.selectedSize?.toString() ?? '',
              'productId': item.productId.toString(),
            };
          }

          // Create the order data
          final orderData = {
            'user_id': _userId,
            'selected_address': _selectedAddress!['id'].toString(),
            'final_amount': 0,
            'payment_method': _selectedPaymentMethod!.toLowerCase(),
            'product': productData,
          };

          // Place the order
          await _placeOrder(orderData);
        } catch (e) {
          // Handle errors
          print('Error during checkout: $e');
          _showSnackBar('Order placement failed: $e');
        }
      } else {
        _showSnackBar('Error: User ID not found!');
      }
    } else {
      _showSnackBar('Please select both an address and a payment method');
    }
  }

  Future<void> _placeOrder(Map<String, dynamic> orderData) async {
    const String url = 'http://sntgold.microlanpos.com/api/place-order';

    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: orderData,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Handle success
        print('Order placed successfully: ${response.data}');
        _showSnackBar('Order placed successfully!');
        // Optionally navigate to a success screen or clear the cart
        _clearCart();
      } else {
        // Handle failure
        throw Exception('Failed to place order: ${response.data}');
      }
    } catch (e) {
      // Handle errors
      print('Order placement error: $e');
      _showSnackBar('Order placement failed: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearCart() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clearCart();
  }

// int _calculateTotalAmount(List<Product> cartItems) {
  // Calculate the total amount from the cart items
  // return cartItems.fold(0, (sum, item) {
  // return sum + (item.sizeWisePrice?.price?.first ?? 0) * (item.quantity ?? 1);
  // });
// }

  Future<void> _handleRedirect(
      Response response, Map<String, dynamic> orderData) async {
    print('Redirect detected. Attempting to follow the link...');
    final redirectUrl = response.headers['location']?.first;

    if (redirectUrl != null) {
      final redirectResponse = await _dio.post(
        redirectUrl,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: orderData,
      );

      if (redirectResponse.statusCode == 302) {
        print('Order placed successfully after redirect');
        print(redirectResponse.data);
      } else {
        throw Exception(
            'Failed to place order after redirect: ${redirectResponse.statusCode} - ${redirectResponse.data}');
      }
    } else {
      throw Exception('Redirect location not found.');
    }
  }

  Widget _buildAddressList() {
    if (_isLoadingUserId) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _addressList.length,
      itemBuilder: (context, index) {
        final address = _addressList[index];
        return ListTile(
          title: Text(address['address'] ?? 'No Address'),
          subtitle: Text(address['city'] ?? ''),
          onTap: () {
            setState(() {
              _selectedAddress = address; // Update selected address
            });
          },
          selected: _selectedAddress == address,
        );
      },
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment Method',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        RadioListTile(
          title: const Text('Cash on Delivery'),
          value: 'cod',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const Text('Online Payment'),
          value: 'online',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value.toString();
            });
          },
        ),
      ],
    );
  }

  Widget _buildCartItems(List<Product> cartItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return ListTile(
          // leading: Image.network(item.productImage ?? ''),
          title: Text(item.name ?? 'Product'),
          subtitle: Text(
              'Size: ${item.selectedSize ?? 'N/A'} - Quantity: ${item.quantity}'),
          trailing: Text(item.sizeWisePrice?.price?.first ?? 'N/A'),
        );
      },
    );
  }

  Widget _buildEmptyCart() {
    return const Center(child: Text('Your cart is empty'));
  }
}

// Widget _buildFinalAmount(List<Product> cartItems) {
//     // final totalAmount = _calculateTotalAmount(cartItems);

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Final Amount:',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             '\$${totalAmount.toStringAsFixed(2)}', // Format to 2 decimal places
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
//           ),
//         ],
//       ),
//     );
//   }
