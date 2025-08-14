import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Navigate to login screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bloodtype, size: 100, color: Colors.redAccent),
            SizedBox(height: 20),
            Text(
              'Blood Bank App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}