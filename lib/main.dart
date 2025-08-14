// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/splash/pages/splash_screen.dart';
import 'features/auth/pages/login_screen.dart';
import 'features/auth/pages/signup_screen.dart';
import 'features/home/pages/home_screen.dart';
import 'features/donor/pages/donor_registration_screen.dart';
import 'features/recipient/pages/recipient_request_screen.dart';
import 'features/search/pages/search_screen.dart';
import 'features/profile/pages/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp(); // Placeholder for Firebase setup
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Bank App',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/donor': (context) => DonorRegistrationScreen(),
        '/recipient': (context) => RecipientRequestScreen(),
        '/search': (context) => SearchScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}