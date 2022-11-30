import 'package:cleanify/Screens/Login/LoginScreens.dart';
import 'package:cleanify/Screens/Register/RegisterScreens.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: ((context) => LoginScreen()),
  RegisterScreen.routeName:((context) => RegisterScreen())
};
