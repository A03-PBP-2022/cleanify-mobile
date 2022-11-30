import 'package:cleanify/Screens/Login/LoginScreens.dart';
import 'package:cleanify/routes.dart';
import 'package:cleanify/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    title: "Cleanify",
    theme: theme(),
    initialRoute: LoginScreen.routeName,
    routes: routes,
    )
  );
}
