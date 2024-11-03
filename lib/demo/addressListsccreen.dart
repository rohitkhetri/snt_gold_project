import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/demo/edit_addressscreen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final Dio _dio = Dio();
  List<dynamic> _addressList = [];
  bool _isLoading = true;
  String? _error;
  bool _isLoadingUserId = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId(); // Fetch user ID first
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdInt = prefs.getInt('user_id');

    if (userIdInt != null) {
      setState(() {
        _userId = userIdInt.toString(); // Convert int to String
        _isLoadingUserId = false;
      });
    } else {
      // Try to retrieve user_id as a String
      setState(() {
        _userId = prefs.getString('user_id');
        _isLoadingUserId = false;
      });
    }
    print("Fetched User ID: $_userId");

    // After fetching user ID, fetch the address list
    if (_userId != null) {
      _fetchAddressList();
    } else {
      setState(() {
        _error = 'User ID not found';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchAddressList() async {
    const String url = 'http://sntgold.microlanpos.com/api/address-list';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        queryParameters: {'user_id': _userId}, // Use the fetched user ID
      );

      if (response.statusCode == 200) {
        // Check if response data and 'message' key are not null
        if (response.data != null && response.data['message'] is List) {
          setState(() {
            _addressList = response.data['message']; // Use 'message' key to get the list of addresses
            _isLoading = false; // Set loading to false after fetching data
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
        _error = 'Error: $e'; // Handle the error
        _isLoading = false;
      });
    }
  }

  // Navigate to Add Address Screen
  void _navigateToAddAddress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAddressScreen()),
    ).then((value) {
      if (value == true) {
        _fetchAddressList(); // Refresh the address list after adding a new address
      }
    });
  }

  // Navigate to Edit Address Screen
  void _navigateToEditAddress(dynamic address) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditAddressScreen(address: address)),
    ).then((value) {
      if (value == true) {
        _fetchAddressList(); // Refresh the address list after editing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address List'),
      ),
      body: _isLoadingUserId
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : ListView.builder(
                  itemCount: _addressList.length,
                  itemBuilder: (context, index) {
                    var address = _addressList[index];
                    return Card(
                      child: ListTile(
                        title: Text('${address['first_name']} ${address['last_name']}'),
                        subtitle: Text('${address['address']}, ${address['city']}, ${address['state']} - ${address['postcode']}'),
                        trailing: Text(address['mobile']),
                        onTap: () => _navigateToEditAddress(address), // Navigate to edit address on tap
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAddress, // Navigate to add address screen
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();

  // Text controllers to capture input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;
  String? _error;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId(); // Fetch user ID when screen loads
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdInt = prefs.getInt('user_id');
    setState(() {
      _userId = userIdInt?.toString();
    });
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState?.validate() != true || _userId == null) return;

    setState(() {
      _isLoading = true;
    });

    const String url = 'https://sntgold.microlanpos.com/api/address';

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "user_id": _userId,
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "email": _emailController.text,
          "address": _addressController.text,
          "landmark": _landmarkController.text,
          "state": _stateController.text,
          "city": _cityController.text,
          "postcode": _postcodeController.text,
          "phone": _phoneController.text
        },
      );

      if (response.statusCode == 200) {
        // If successful, return to the previous screen and refresh the address list
        Navigator.pop(context, true);
      } else {
        setState(() {
          _error = 'Failed to save address: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value!.isEmpty ? 'Please enter first name' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value!.isEmpty ? 'Please enter last name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter email' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Please enter address' : null,
              ),
              TextFormField(
                controller: _landmarkController,
                decoration: const InputDecoration(labelText: 'Landmark'),
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State'),
                validator: (value) => value!.isEmpty ? 'Please enter state' : null,
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) => value!.isEmpty ? 'Please enter city' : null,
              ),
              TextFormField(
                controller: _postcodeController,
                decoration: const InputDecoration(labelText: 'Postcode'),
                validator: (value) => value!.isEmpty ? 'Please enter postcode' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _saveAddress,
                      child: const Text('Save Address'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
