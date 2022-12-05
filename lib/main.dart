import 'dart:convert';

import 'package:cleanify/authentication/page/loginPage.dart';
import 'package:cleanify/core/home.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/blog/page/index.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    // drawer: NavigationDrawerWidget(),
    // // endDrawer: NavigationDrawerWidget(),
    // appBar: AppBar(
    //   title: Text(MyApp.title),
    // ),
    body: Builder(
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32),
        
        //Coba ngeget
        child: ElevatedButton(
          onPressed: () async {
            final response = await http.get(
              Uri.parse("https://cleanifyid.up.railway.app/auth/api/login"),
                headers: <String, String>{
                  'Content-Type': 'application/json;'
                },
            );
            print(response.body);
            Map<String, dynamic> map = jsonDecode(response.body);
          },
          style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0), backgroundColor: Colors.green,
          ),
          child: Text(
              "TESTTT get",
              style: TextStyle(color: Colors.white),
            ),
        ),
        
      ),
    ),
  );
}


