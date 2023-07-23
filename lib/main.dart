import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_state/components/bottom_navigation_bar.dart';
import 'package:fit_state/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure that Firebase is initialized before the app starts
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(FitState());
}

class FitState extends StatelessWidget {
  FitState({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit State',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _auth.currentUser == null
          ? SplashScreen()
          : BottomNavigationBarWidget(),
    );
  }
}
