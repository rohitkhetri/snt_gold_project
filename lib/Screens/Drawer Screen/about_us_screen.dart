import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color.fromARGB(216, 226, 165, 45),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title section
            const Text(
              'About SNT Gold',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(216, 226, 165, 45),
              ),
            ),
            const SizedBox(height: 16.0),

            // Image (optional)
            Center(
              child: Image.asset(
                'assets/snt_logo.png',
                // 'https://sntgold.microlanpos.com/assets/images/logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16.0),

            // Description text
            const Text(
              'SNT Gold is a renowned jewelry company committed to offering high-quality gold and diamond products...',
              style: TextStyle(fontSize: 16.0, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),

            // Mission statement
            const Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(216, 226, 165, 45),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'We aim to provide our customers with the finest jewelry, ensuring trust, purity, and authenticity...',
              style: TextStyle(fontSize: 16.0, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),

            // Values section
            const Text(
              'Our Values',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(216, 226, 165, 45),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Integrity, quality, and customer satisfaction are the pillars of our business...',
              style: TextStyle(fontSize: 16.0, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24.0),

            // Contact information (optional)
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(216, 226, 165, 45),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'For inquiries, reach out to us at sntgold1@gmail.com or call +91 12345 67890.',
              style: TextStyle(fontSize: 16.0, height: 1.5),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
