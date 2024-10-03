import 'package:flutter/material.dart';
import 'package:snt_gold_project/Dashboard/dashboard.dart';
import 'package:snt_gold_project/Login_Registration/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                
                // Email Input Field
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const Positioned(
                      //top: 10,
                      bottom: 0,
                      right: 0, 
                      child: Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.black,
                        ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Password Input Field
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const Positioned(
                      //top: 10,
                      bottom: 0,
                      right: 0, 
                      child: Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Colors.black,
                        ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Login Button
                SizedBox(
                  width: double.infinity, 
                  child: ElevatedButton(
                    onPressed: (){
                      if(emailController.text == 'user' &&
                         passwordController.text == 'pass'){
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const DashboardScreen()),
                          );
                         } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
                         }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(216, 226, 165, 45),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                const Text('Dont have an Account Yet!!?'),
                
                const SizedBox(height: 10),
                
                // Continue with Facebook Button
                SizedBox(
                  width: double.infinity, 
                  child: InkResponse(
                    onTap: (){
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                  ),
                    
                

                // SizedBox(height: 10),

                // // Continue with Facebook Button
                // SizedBox(
                //   width: double.infinity, 
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                      
                //     },
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: Colors.black, backgroundColor: Colors.white,// Facebook color
                //       padding: EdgeInsets.symmetric(vertical: 16),
                //     ),
                //     icon: const Icon(Icons.facebook),
                //     label: RichText(text: const TextSpan(
                //       text: 'Continue with ',
                //       style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: 'Google',
                //           style: TextStyle(fontWeight: FontWeight.bold)
                //         )
                //       ]
                //     ),)
                //   ),
                // ),
                
                // const SizedBox(height: 10),
                
                // // Continue with Apple Button
                // SizedBox(
                //   width: double.infinity, 
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                      
                //     },
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: Colors.black,
                //       backgroundColor: Colors.white,
                //       padding: const EdgeInsets.symmetric(vertical: 16),
                //     ),
                //     icon: const Icon(Icons.apple),
                //     label: RichText(
                //       text: const TextSpan(
                //         text: 'Continue with ',
                //         style: TextStyle(color: Colors.black,fontWeight:  FontWeight.normal),
                //         children: <TextSpan>[
                //           TextSpan(
                //             text: 'Apple',
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}