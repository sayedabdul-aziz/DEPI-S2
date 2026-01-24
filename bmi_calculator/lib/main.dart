import 'package:bmi_calculator/bmi/page/bmi_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// custom widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiScreen(),
    );
  }
}
