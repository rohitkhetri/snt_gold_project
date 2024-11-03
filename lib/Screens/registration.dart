import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/snt_logo.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Please Register to continue using our App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                      firstnameController, 'First Name', Icons.person),
                  const SizedBox(height: 10),
                  _buildTextField(
                      lastnameController, 'Last Name', Icons.person),
                  const SizedBox(height: 10),
                  _buildTextField(emailController, 'Email', Icons.email),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          passwordController,
                          'Password',
                          Icons.lock,
                          obscureText: !_isPasswordVisible,
                          toggleVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          isVisible: _isPasswordVisible,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          confirmPasswordController,
                          'Confirm Password',
                          Icons.lock,
                          obscureText: !_isConfirmPasswordVisible,
                          toggleVisibility: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                          isVisible: _isConfirmPasswordVisible,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(phoneController, 'Phone', Icons.phone),
                  const SizedBox(height: 10),
                  _buildTextField(addressController, 'Address', Icons.home),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(landmarkController, 'Landmark',
                              Icons.location_on)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(
                              stateController, 'State', Icons.map)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              cityController, 'City', Icons.location_city)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(
                              zipcodeController, 'ZipCode', Icons.code)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(246, 226, 165, 45),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: InkResponse(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Already have an Account!?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
    VoidCallback? toggleVisibility,
    bool isVisible = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        prefixIcon: Icon(icon),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(246, 226, 165, 45), width: 2.0),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (_validateInputs()) {
      setState(() {
        _isLoading = true;
      });

      var data = {
        "fname": firstnameController.text,
        "lname": lastnameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "address": addressController.text,
        "landmark": landmarkController.text,
        "state": stateController.text,
        "city": cityController.text,
        "zipcode": zipcodeController.text,
        "phone": phoneController.text,
      };

      Dio dio = Dio();
      try {
        String url = 'https://sntgold.microlanpos.com/api/register';
        var response = await dio.post(
          url,
          data: data,
          options: Options(headers: {'Content-Type': 'application/json'}),
        );

        print('Response status: ${response.statusCode}');
        print('Response data: ${response.data}'); // Print the response data

        if (response.statusCode == 201 &&
            response.data is Map<String, dynamic>) {
          if (response.data.containsKey('token') &&
              response.data['user'] is Map) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('auth_token', response.data['token']);

            // Log the user ID data before parsing
            print("User ID data: ${response.data['user']['id']}");

            // Ensure user ID is stored as an integer
            int? userId;
            try {
              userId = int.parse(response.data['user']['id'].toString());
            } catch (e) {
              print('User ID parsing error: $e');
              userId = 0; // Assign a default value if parsing fails
            }
            await prefs.setInt('user_id', userId);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful!'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            _showError('Unexpected response structure. Please try again.');
          }
        } else {
          _showError(response.data['message'] ??
              'Registration failed. Please try again.');
        }
      } catch (e) {
        if (e is DioException) {
          print('DioError: ${e.response?.data}');
          String errorMessage = e.response?.data['message'] ??
              'An error occurred. Please try again.';
          _showError(errorMessage);
        } else {
          print('Unknown error: $e');
          _showError('An unknown error occurred. Please try again.');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _validateInputs() {
    if (firstnameController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.isEmpty) {
      _showError('Please fill all the fields.');
      return false;
    }

    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      _showError('Please enter a valid email address.');
      return false;
    }

    String phonePattern = r'^[0-9]{10}$';
    if (!RegExp(phonePattern).hasMatch(phoneController.text)) {
      _showError('Please enter a valid 10-digit phone number.');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showError('Passwords do not match.');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
