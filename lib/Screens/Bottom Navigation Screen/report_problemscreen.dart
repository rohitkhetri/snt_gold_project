import 'package:flutter/material.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Problem'),
      ),
      body: const Center(
        child: Text('Report a Problem form will be displayed here.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}