import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/app_state_provider.dart';
// import '../providers/app_state_provider.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User: ${userEmail ?? 'Unknown'}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider.notifier).state = null; // Clear email
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}