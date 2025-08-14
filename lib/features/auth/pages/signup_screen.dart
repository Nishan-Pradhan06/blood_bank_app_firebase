import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signUp() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) ||
        password.length < 6 ||
        password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please check your inputs: valid email, password 6+ chars, passwords match')),
      );
      return;
    }
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _signUp, child: Text('Sign Up')),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}