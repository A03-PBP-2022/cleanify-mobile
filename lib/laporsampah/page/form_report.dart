import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';

class FormReportPage extends StatefulWidget {
  // final String id;
  const FormReportPage({super.key});

  @override
  _FormReportPageState createState() => _FormReportPageState();
}

class _FormReportPageState extends State<FormReportPage> {
  final _formKey = GlobalKey<FormState>();

  String LocationField = "";
  String UrgencyField = "";
  String DescriptionField = "";
  String ContactField = "";
  Future<void> submit(BuildContext context, String idUser) async {
    String idPemilik = idUser;
    final response = await http.post(
        Uri.parse(
            "" +
                idPemilik),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'the_location': LocationField,
          'the_urgency': UrgencyField,
          'the-description': DescriptionField,
          'the_contact': ContactField,
        }));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawer(),
      appBar: AppBar(
        title: Text("Pelaporan Wilayah Sampah"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Wilayah sampah",
                      labelText: "Location",
                      icon: Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        LocationField = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        LocationField = value!;
                      });
                    },
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
                    // controller: UrgencyField,
                    decoration: new InputDecoration(
                      hintText: "out of 5",
                      labelText: "Urgency",
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        UrgencyField = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        UrgencyField = value!;
                      });
                    },
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
                    // controller: DescriptionField,
                    decoration: new InputDecoration(
                      hintText: "Description",
                      labelText: "Minimum of 50 words",
                      icon: Icon(Icons.assignment),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        DescriptionField = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        DescriptionField = value!;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill the location's description";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // controller: ContactField,
                    decoration: new InputDecoration(
                      hintText: "0821-xxxx-xxxx",
                      labelText: "Contact Information",
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        ContactField = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        ContactField = value!;
                      });
                    },
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Please fill in your contact details";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
