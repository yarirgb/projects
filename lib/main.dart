import 'package:flutter/material.dart';
import 'package:projects/pages/splash1.dart';
import 'package:projects/pages/splash_second.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstSplash(),
    );
  }
}
// MaterialApp
