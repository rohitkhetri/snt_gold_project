import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddressManagementPage extends StatefulWidget {
  const AddressManagementPage({super.key});

  @override
  _AddressManagementPageState createState() => _AddressManagementPageState();
}

class _AddressManagementPageState extends State<AddressManagementPage> {
  final Dio _dio = Dio();
  List<dynamic> _addressList = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final int userId = 7; // Set your user ID

  @override
  void initState() {
    super.initState();
    _fetchAddressList();
  }

  Future<void> _fetchAddressList() async {
    const String url = 'http://sntgold.microlanpos.com/api/address-list';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        setState(() {
          _addressList = response.data;
        });
      } else {
        throw Exception('Failed to load addresses: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching address list: $e');
    }
  }

  Future<void> _addAddress() async {
    const String url = 'http://sntgold.microlanpos.com/api/address';

    final addressData = {
      "user_id": userId,
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "landmark": _landmarkController.text,
      "state": _stateController.text,
      "city": _cityController.text,
      "postcode": _postcodeController.text,
      "phone": _phoneController.text,
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: addressData,
      );

      if (response.statusCode == 200) {
        print('Address added successfully');
        _fetchAddressList(); // Refresh the address list
        _clearForm();
      } else {
        throw Exception('Failed to add address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding address: $e');
    }
  }

  Future<void> _editAddress(int addressId) async {
    const String url = 'http://sntgold.microlanpos.com/api/edit-address';

    final addressData = {
      "id": addressId,
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "address": _addressController.text,
      "landmark": _landmarkController.text,
      "state": _stateController.text,
      "city": _cityController.text,
      "postcode": _postcodeController.text,
      "phone": _phoneController.text,
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: addressData,
      );

      if (response.statusCode == 200) {
        print('Address updated successfully');
        _fetchAddressList(); // Refresh the address list
        _clearForm();
      } else {
        throw Exception('Failed to edit address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error editing address: $e');
    }
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _addressController.clear();
    _landmarkController.clear();
    _stateController.clear();
    _cityController.clear();
    _postcodeController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Management'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your first name'
                          : null,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your last name' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your address' : null,
                    ),
                    TextFormField(
                      controller: _landmarkController,
                      decoration: const InputDecoration(labelText: 'Landmark'),
                    ),
                    TextFormField(
                      controller: _stateController,
                      decoration: const InputDecoration(labelText: 'State'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your state' : null,
                    ),
                    TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(labelText: 'City'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your city' : null,
                    ),
                    TextFormField(
                      controller: _postcodeController,
                      decoration: const InputDecoration(labelText: 'Postcode'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your postcode' : null,
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addAddress();
                        }
                      },
                      child: const Text('Add Address'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Saved Addresses',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _addressList.length,
              itemBuilder: (context, index) {
                final address = _addressList[index];
                return ListTile(
                  title:
                      Text('${address['first_name']} ${address['last_name']}'),
                  subtitle: Text(
                      '${address['address']}, ${address['city']}, ${address['state']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Populate form fields for editing
                      _firstNameController.text = address['first_name'];
                      _lastNameController.text = address['last_name'];
                      _emailController.text = address['email'];
                      _addressController.text = address['address'];
                      _landmarkController.text = address['landmark'];
                      _stateController.text = address['state'];
                      _cityController.text = address['city'];
                      _postcodeController.text = address['postcode'];
                      _phoneController.text = address['phone'];

                      // Call edit function (replace address ID as needed)
                      _editAddress(address[
                          'id']); // Adjust this line according to your API
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
