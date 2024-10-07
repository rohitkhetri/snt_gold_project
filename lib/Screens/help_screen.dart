import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHelpOption(
            context,
            title: 'Frequently Asked Questions',
            icon: Icons.question_answer,
            onTap: () {
              // Navigate to FAQ screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'Contact Support',
            icon: Icons.support_agent,
            onTap: () {
              // Navigate to Contact Support screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactSupportScreen()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'Report a Problem',
            icon: Icons.report_problem,
            onTap: () {
              // Navigate to Report Problem screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportProblemScreen()),
              );
            },
          ),
          _buildHelpOption(
            context,
            title: 'App Feedback',
            icon: Icons.feedback,
            onTap: () {
              // Navigate to Feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(BuildContext context, {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 30),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

// Placeholder for FAQ Screen
class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
      ),
      body: const Center(
        child: Text('List of FAQs will be displayed here.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// Placeholder for Contact Support Screen
class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support'),
      ),
      body: const Center(
        child: Text('Contact Support information will be displayed here.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// Placeholder for Report Problem Screen
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

// Placeholder for Feedback Screen
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Feedback'),
      ),
      body: const Center(
        child: Text('Feedback form will be displayed here.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
