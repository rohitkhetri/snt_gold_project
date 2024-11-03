import 'package:flutter/material.dart';

class PolicyTerms extends StatelessWidget {
  const PolicyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Terms'),
      ),
      body: const Center(
          child: Text(
        'Policy Terms',
        style: TextStyle(fontSize: 24),
      )),
    );
  }
}
