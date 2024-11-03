import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_gold_project/Screens/dashboard.dart';
import 'package:snt_gold_project/Screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    if (_validateInputs()) {
      setState(() {
        _isLoading = true;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    String? email = prefs.getString('email');

    if (token != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    }
  }

  bool _validateInputs() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showError('Please fill all the fields.');
      return false;
    }

    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      _showError('Please enter a valid email address.');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please Login/Sign-Up to continue our App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 30),

                _buildTextField(emailController, 'Username', Icons.person),

                const SizedBox(height: 20),
                _buildTextField(passwordController, 'Password', Icons.lock,
                    obscureText: true),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            _login();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(246, 226, 165, 45),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Dont have an Account Yet!!?'),
                const SizedBox(height: 10),

                SizedBox(
                    width: double.infinity,
                    child: InkResponse(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        prefixIcon: Icon(icon),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(246, 226, 165, 45), width: 2.0),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_validateInputs()) {
      setState(() {
        _isLoading = true;
      });
    }
    Dio dio = Dio();
    String url = 'https://sntgold.microlanpos.com/api/login';

    try {
      var response = await dio.post(
        url,
        data: {
          "email": emailController.text,
          "password": passwordController.text,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        int userId = response.data['user']['id'];
        String email = response.data['user']['email'];
        print('User ID: $userId');
        print('Token: $token');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setInt('user_id', userId);
        await prefs.setString('email', email);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );

        await Future.delayed(const Duration(seconds: 1));

        // Navigate to Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed, please try again')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error: Please use correct email and password')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
