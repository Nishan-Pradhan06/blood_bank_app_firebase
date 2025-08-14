import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/app_state_provider.dart';
// import '../../providers/app_state_provider.dart'; // Correct import path

class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) && password.length >= 6) {
      ref.read(userProvider.notifier).state = email; // Store email
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid email and password (6+ characters)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Log In')),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}