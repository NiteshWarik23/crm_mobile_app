import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? routeName;

  const ErrorScreen({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Not Found")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              "Oops! The page \"$routeName\" does not exist.",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
