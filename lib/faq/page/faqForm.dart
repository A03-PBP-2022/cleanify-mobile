import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cleanify/core/drawer.dart';

class FAQFormPage extends StatefulWidget {
  const FAQFormPage({super.key});

  @override
  State<FAQFormPage> createState() => _FaqFormState();
}

class FaqsContent {
  late String q;
  late String a;

  FaqsContent({
    required this.a,
    required this.q,
  });
}

class _FaqFormState extends State<FAQFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? q;
  String? a;
  Future<FaqsContent>? _futureAlbum;
  final TextEditingController _in = TextEditingController();
  final TextEditingController _in2 = TextEditingController();

  void submit(String q, String a) async {
    var url = Uri.parse('https://cleanifyid.up.railway.app/faq/addFlutter/');
    var map = <String, dynamic>{};
    map["q"] = q;
    map["a"] = a;
    var response = await http.post(url, body: map);
    print(response.body);
    // onPressed(BuildContext context) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const FAQFormPage()),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Faqs'),
      ),
      drawer: const GlobalDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _in,
                    decoration: InputDecoration(
                      hintText: "Ask Your Question Here",
                      labelText: "Question",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat  diketik
                    onChanged: (String? value) {
                      setState(() {
                        q = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _in2,
                    decoration: InputDecoration(
                      hintText: "Input Your Question Here",
                      labelText: "Answer",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat diketik
                    onChanged: (String? ans) {
                      setState(() {
                        a = ans!;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.all(15.0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        submit(q!, a!);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQFormPage()));
                    },
                    child: const Text("Add",
                        style: TextStyle(color: Colors.white)),
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
