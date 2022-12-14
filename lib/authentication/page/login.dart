import 'package:cleanify/consts.dart';
import 'package:cleanify/core/home.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/authentication/page/register.dart';
import 'package:cleanify/authentication/models/user.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:tkuas/utils/cookie_request.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isFailed = false;

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final user = context.watch<User>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      'Log in to your account.',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
                    )),
                if (isFailed)
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(color: Colors.red[900], borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Login failed! Re-check your credentials!',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                      )),
                Form(
                    key: _loginFormKey,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(250, 250, 250, 0.95),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Email',
                                  prefixIcon: const Icon(Icons.email),
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(250, 250, 250, 0.95),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: _controllerPassword,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    color: const Color.fromRGBO(200, 200, 200, 1),
                                    splashRadius: 1,
                                    icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                    onPressed: togglePasswordView,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                                  ),
                                  onPressed: () async {
                                    if (_loginFormKey.currentState!.validate()) {
                                      const url = "$endpointDomain/auth/api/login";
                                      await request.login(url, {
                                        'email': _controllerEmail.text,
                                        'password': _controllerPassword.text
                                      });
                                      // _controllerPassword.text);
                                      setState(() {
                                        isFailed = false;
                                      });
                                      print(request.jsonData);
                                      if (request.loggedIn) {
                                        print("Logged in!");
                                        final info = request.jsonData['info'];
                                        user.pk = info['pk'];
                                        user.email = info['email'];
                                        user.username = info['username'];
                                        user.name = info['name'];
                                        user.phoneNumber = info['phoneNumber'];
                                        user.address = info['address'];
                                        user.role = info['role'];
                                        user.permissions = (info['permissions'] as List).map((item) => item as String).toList();
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Successfully logged in!"),
                                        ));
                                      } else {
                                        setState(() {
                                          isFailed = true;
                                        });
                                        print("Failed!");
                                        // showAlertDialog(context);
                                      }
                                    } else {
                                      print("tidak valid");
                                    }
                                  },
                                  child: const Text("Login"),
                                ))
                          ],
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Register',
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ));
                      },
                    ),
                    const Text('if you dont have an account.'),
                  ],
                )
              ],
            )));
  }
}
