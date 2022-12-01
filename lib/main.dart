import 'package:cleanify/core/home.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/blog/page/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO Untuk dikembalikan ke HomePage
    // Widget home = const HomePage();
    Widget home = const BlogIndexPage();
    return MaterialApp(
      title: 'Cleanify',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: home,
    );
  }
}
