import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/core/home.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/blog/page/index.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Widget home = const HomePage();
    // Widget home = const BlogIndexPage();
    return MultiProvider(
        providers: [
          Provider<CookieRequest>(create: (_) => CookieRequest()),
          Provider<User>(create: (_) => User())
        ],
        child: MaterialApp(
          title: 'Cleanify',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: home,
        ),
    );
  }
}