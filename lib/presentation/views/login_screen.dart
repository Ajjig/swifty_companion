import 'package:flutter/material.dart';
import 'package:swifty_companion/data/providers/api_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to EazyLogin77',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                debugPrint('Login button pressed'),
                ApiProvider().login().then((value) {
                  if (value) {
                    debugPrint('Login successful !');
                  } else {
                    debugPrint('Login failed !');
                  }
                }).catchError((error) {
                  debugPrint('Error: $error');
                })
              },
              child: const Text('Login with intra42'),
            ),
          ],
        ),
      ),
    );
  }
}
