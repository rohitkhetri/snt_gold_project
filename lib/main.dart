import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Model/cart_model.dart';
import 'package:snt_gold_project/Provider/ProductProvider.dart';
import 'package:snt_gold_project/Provider/FavoriteProvider.dart';
import 'package:snt_gold_project/Splash%20Screen/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers:
      [
      ChangeNotifierProvider(create: (context) => CartModel()),
      ChangeNotifierProvider(create: (context) => Productprovider()),
      ChangeNotifierProvider(create: (context) => Favoriteprovider()),
    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}