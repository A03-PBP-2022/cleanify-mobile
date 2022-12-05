import 'package:flutter/material.dart';
import 'package:cleanify/authentication/page/registerPage.dart';
import 'package:http/http.dart' as http;
import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/main.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:tkuas/utils/cookie_request.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                      'Masuk ke Akun Pengguna',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    )),
                Form(
                    key: _loginFormKey,
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: _controllerPassword,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    splashRadius: 1,
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePasswordView,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_loginFormKey.currentState!
                                        .validate()) {
                                      //const url = "http://127.0.0.1:8000/auth/login_flutter/";
                                      const url =
                                          "https://cleanifyid.up.railway.app/auth/api/login";
                                      final response = await request.login(
                                          url, {
                                            'email': _controllerEmail.text,
                                            'password': _controllerPassword.text
                                          });
                                      // _controllerPassword.text);
                                      if (request.loggedIn) {
                                        Navigator.pop(context);
                                        print("Logged in!");
                                      } else {
                                        print("Failed!");
                                        // showAlertDialog(context);
                                      }
                                    } else {
                                      print("tidak valid");
                                    }
                                  },
                                  child: Text("LOGIN"),
                                ))
                          ],
                        ))),
                Row(
                  children: <Widget>[
                    TextButton(
                      child: const Text(
                        'Register',
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                      },
                    ),
                    const Text('if you dont have an account.'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            )));
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Coba Lagi"),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Email dan password tidak cocok!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  showAlertDialog2(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert1 = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Anda berhasil login"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
