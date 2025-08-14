import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/app_state_provider.dart';
// import '../providers/app_state_provider.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Bank Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${userEmail ?? 'User'}!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/donor'),
              child: Text('Donate Blood'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/recipient'),
              child: Text('Request Blood'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/search'),
              child: Text('Find Donors'),
            ),
          ],
        ),
      ),
    );
  }
}