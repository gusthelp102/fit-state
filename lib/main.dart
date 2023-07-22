import 'package:flutter/material.dart';

void main() {
  runApp(const FitState());
}

class FitState extends StatelessWidget {
  const FitState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit State',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(),
    );
  }
}
