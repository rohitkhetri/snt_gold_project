import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final dynamic address; // Address data to be edited

  const EditAddressScreen({super.key, required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing address data
    _firstNameController.text = widget.address['first_name'];
    _lastNameController.text = widget.address['last_name'];
    _emailController.text = widget.address['email'];
    _addressController.text = widget.address['address'];
    _landmarkController.text = widget.address['landmark'];
    _stateController.text = widget.address['state'];
    _cityController.text = widget.address['city'];
    _postcodeController.text = widget.address['postcode'];
    _phoneController.text = widget.address['mobile'];
  }

  Future<void> _editAddress() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() {
      _isLoading = true;
    });

    const String url = 'http://sntgold.microlanpos.com/api/edit-address'; // Update this URL accordingly

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "id": widget.address['id'], // Include the ID of the address
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "email": _emailController.text,
          "address": _addressController.text,
          "landmark": _landmarkController.text,
          "state": _stateController.text,
          "city": _cityController.text,
          "postcode": _postcodeController.text,
          "phone": _phoneController.text,
        },
      );

      if (response.statusCode == 302) {
        Navigator.pop(context, true);
      } else {
        setState(() {
          _error = 'Failed to edit address: ${response.statusCode}';
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
        title: const Text('Edit Address'),
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
                      onPressed: _editAddress,
                      child: const Text('Save Changes'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
