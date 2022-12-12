import 'package:cleanify/consts.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();

  bool isFailed = false;

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String role = 'user';
  List<String> listRole = [
    'user',
    'crew'
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text(
                'Account Registration',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                child: TextFormField(
                  controller: controllerEmail,
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: "Email",
                    hintText: "Ex: myname@example.com",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email cannot be empt';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Username",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username cannot be empt';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
//obscureText: true,
                  controller: controllerPassword,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.security),
                    labelText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    suffixIcon: IconButton(
                      color: const Color.fromRGBO(200, 200, 200, 1),
                      splashRadius: 1,
                      icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      onPressed: togglePasswordView,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
//obscureText: true,
                  controller: controllerConfirmPassword,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.security),
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                    suffixIcon: IconButton(
                      color: const Color.fromRGBO(200, 200, 200, 1),
                      splashRadius: 1,
                      icon: Icon(isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      onPressed: togglePasswordView,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password cannot be empty';
                    }
// if (value! != ) kasi validasi kalo imput != sama password
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerFullName,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: "Full Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerPhoneNumber,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: "Phone Number",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerAddress,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.business),
                    labelText: "Address",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Address cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.class_),
                title: const Text(
                  'Role',
                ),
                trailing: DropdownButton(
                  value: role,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: listRole.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      role = newValue!.toLowerCase();
                    });
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          const url = "$endpointDomain/auth/api/register";
                          final response = await request.post(url, {
                            'email': controllerEmail.text,
                            'username': controllerUsername.text,
                            'password1': controllerPassword.text,
                            'password2': controllerConfirmPassword.text,
                            'name': controllerFullName.text,
                            'phoneNumber': controllerPhoneNumber.text,
                            'address': controllerAddress.text,
                            'role': role,
                          });

                          if (response['status']) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Account has been successfully registered! You may now log in."),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("An error occured, please try again."),
                            ));
                          }
                          // _controllerPassword.text);
                          setState(() {
                            isFailed = false;
                          });
                          print(request.jsonData);
                          print("Signed in!");
                        } else {
                          print("tidak valid");
                        }
                      },
                      // child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 30),
                          textStyle: const TextStyle(
                            color: Colors.white,
                          )),
                      child: const Text('Register')))
            ]),
          ),
        ),
      ),
    );
  }
}
