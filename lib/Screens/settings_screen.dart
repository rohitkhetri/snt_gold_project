import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Settings screen');
  }
}

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({Key? key}) : super(key: key);

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