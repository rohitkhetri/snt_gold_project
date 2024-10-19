import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Screens/dashboard.dart';

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
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/snt_logo.png'),
                ),

                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Please Register to continue using our App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 20),

                // Input Fields
                _buildTextField(firstnameController, 'Username', Icons.person),
                const SizedBox(height: 10),
                _buildTextField(lastnameController, 'Username', Icons.person),
                const SizedBox(height: 10),
                _buildTextField(emailController, 'Email', Icons.email),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildTextField(passwordController, 'Password', Icons.lock, obscureText: true)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(confirmPasswordController, 'Confirm Password', Icons.lock, obscureText: true)),
                  ],
                ),
                const SizedBox(height: 10),

                _buildTextField(phoneController, 'Phone', Icons.phone),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildTextField(landmarkController, 'Landmark', Icons.location_on)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(stateController, 'State', Icons.map)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: _buildTextField(cityController, 'City', Icons.location_city)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildTextField(zipcodeController, 'ZipCode', Icons.code)),
                  ],
                ),
                const SizedBox(height: 10),

                // Register Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(246, 226, 165, 45),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Register', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build a text field with an icon
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        prefixIcon: Icon(icon),
        // border: OutlineInputBorder(
        //   // borderRadius: BorderRadius.circular(10),
        //   // borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(246, 226, 165, 45), width: 2.0),
        ),
      ),
    );
  }

  
  // Register function to handle registration logic
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
 // Prepare the data for registration
    var data = {
      "fname": firstnameController.text,
      "lname": lastnameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "address": addressController.text,  // You might want to add address input
      "landmark": landmarkController.text,
      "state": stateController.text,
      "city": cityController.text,
      "zipcode": zipcodeController.text,
      "phone": phoneController.text,
    };

    // API Call
   try {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));

    String url = 'https://sntgold.microlanpos.com/api/register';
    var response = await dio.post(
      url,
      data: data,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

      // Handle response
      if (response.statusCode == 200) {
        // Registration successful
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']); // Assuming the token is returned
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failed. Please try again.')));
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}