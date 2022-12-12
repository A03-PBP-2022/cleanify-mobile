import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/consts.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Widget home = homePage;
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