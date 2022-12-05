import 'package:cleanify/authentication/page/loginPage.dart';
import 'package:cleanify/core/home.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/blog/page/index.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Widget home = const HomePage();
//     // Widget home = const BlogIndexPage();
//     return MaterialApp(
//       title: 'Cleanify',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: home,
//     );
//   }
// }

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'Flutter App',
                theme: ThemeData(
                    primarySwatch: Colors.green,
                ),
                home: const HomePage(),
                routes: {
                    "/login": (BuildContext context) =>  LoginPage(),
                },
            ),
        );
    }
}
