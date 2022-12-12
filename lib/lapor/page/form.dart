import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:cleanify/consts.dart';

class FormReportPage extends StatefulWidget {
  const FormReportPage({super.key});

  @override
  _FormReportPageState createState() => _FormReportPageState();
}

class _FormReportPageState extends State<FormReportPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController locationField = TextEditingController(text: "");
  final TextEditingController urgencyField = TextEditingController(text: "");
  final TextEditingController descriptionField =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      drawer: const GlobalDrawer(),
      appBar: AppBar(
        title: const Text("Report Locations"),
      ),
      body: Form(
        key: _loginFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Help Us Report Dump Areas!",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: locationField,
                    decoration: InputDecoration(
                      hintText:
                          "ex: The river next to BCA building, Ahmad Yani Road",
                      labelText: "Location",
                      icon: const Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the detail of location!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: urgencyField,
                    decoration: InputDecoration(
                      hintText: "Rate the urgency out of 5",
                      labelText: "Urgency Level",
                      icon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's urgency level!";
                      } else {
                        try {
                          var intValue = int.parse(value.toString());
                          if (intValue < 1 || intValue > 5) {
                            return "Fill with integers between 1-5!";
                          }
                        } catch (e) {
                          return "Fill with integers!";
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionField,
                    decoration: InputDecoration(
                      hintText: "ex: Dangerous electronic waste",
                      labelText: "Description",
                      icon: const Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's description!";
                      } else if (value.toString().length < 10) {
                        return "Description is too short!";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade700),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        const url = "$endpointDomain/report/reportlocation/";
                        final response = await request.post(url, {
                          'location': locationField.text,
                          'urgency': urgencyField.text,
                          'description': descriptionField.text,
                        });
                        print(response);
                        // Map<String, dynamic> data = jsonDecode(response);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormReportPage()),
                        );
                      }
                    },
                    child: const Text(
                      'Submit',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
