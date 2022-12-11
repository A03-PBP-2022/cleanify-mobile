import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:cleanify/laporsampah/page/list_report.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class FormReportPage extends StatefulWidget {
  // final String id;
  const FormReportPage({super.key});

  @override
  _FormReportPageState createState() => _FormReportPageState();
}

class _FormReportPageState extends State<FormReportPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController LocationField = TextEditingController(text: "");
  final TextEditingController UrgencyField = TextEditingController(text: "");
  final TextEditingController DescriptionField = TextEditingController(text: "");
  final TextEditingController DateField = TextEditingController(text: "");

  // Future<void> submit(BuildContext context) async {
  //   String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  //   const url = "https://cleanifyid.up.railway.app/report/";
  //   final response = await http.post(Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'location': LocationField,
  //         'urgency': UrgencyField,
  //         'description': DescriptionField,
  //         'contact': ContactField,
  //         'date': date,
  //       }));
  //   print(response);
  //   print(response.body);
  // }

  // void printHasil(BuildContext context) {
  //   print(LocationField);
  //   print(UrgencyField);
  //   print(DateField);
  //   print(DescriptionField);
  // }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: AppBar(
        title: Text("Pelaporan Wilayah Sampah"),
      ),
      body: Form(
        key: _loginFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: LocationField,
                    decoration: new InputDecoration(
                      hintText: "Wilayah sampah",
                      labelText: "Location",
                      icon: Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    // onChanged: (String? value) {
                    //   setState(() {
                    //     LocationField = value!;
                    //   });
                    // },
                    // onSaved: (String? value) {
                    //   setState(() {
                    //     LocationField = value!;
                    //   });
                    // },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's detail";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: UrgencyField,
                    decoration: new InputDecoration(
                      hintText: "out of 5",
                      labelText: "Urgency",
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    // onChanged: (String? value) {
                    //   setState(() {
                    //     UrgencyField = value!;
                    //   });
                    // },
                    // onSaved: (String? value) {
                    //   setState(() {
                    //     UrgencyField = value!;
                    //   });
                    // },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's urgency level";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: DescriptionField,
                    decoration: new InputDecoration(
                      hintText: "Description",
                      labelText: "Minimum of 50 words",
                      icon: Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    // onChanged: (String? value) {
                    //   setState(() {
                    //     DescriptionField = value!;
                    //   });
                    // },
                    // onSaved: (String? value) {
                    //   setState(() {
                    //     DescriptionField = value!;
                    //   });
                    // },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's description";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    child: const Text(
                      'Submit',
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade700),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        const url = "https://cleanifyid.up.railway.app/report/reportlocation/";
                        final response = await request.post(url, {
                          'location': LocationField.text,
                          'urgency': UrgencyField.text,
                          'description': DescriptionField.text,
                        });
                        print(response);
                        // Map<String, dynamic> data = jsonDecode(response);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormReportPage()),
                        );

                      };
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
