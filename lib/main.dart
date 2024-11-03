import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snt_gold_project/Provider/cart_provider.dart';
import 'package:snt_gold_project/Provider/favoriteProvider.dart';
import 'package:snt_gold_project/Provider/ordersProvider.dart';
import 'package:snt_gold_project/Screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => Favoriteprovider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
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
