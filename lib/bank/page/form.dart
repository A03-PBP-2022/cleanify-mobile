import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/bank/page/my.dart';
import 'package:cleanify/consts.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

List<BankSampahJsonPage> listData = [];


class BankSampahFormPage extends StatefulWidget {
    const BankSampahFormPage({super.key});

    @override
    State<BankSampahFormPage> createState() => _BankSampahFormPageState();
}

class _BankSampahFormPageState extends State<BankSampahFormPage> {
    final _formKey = GlobalKey<FormState>();
    DateTime _dateTime = DateTime.now();
    String? _contact;
    String? _address;
    String? _pilihan;
    final List<String> _listPilihan = ['Organik', 'Anorganik', 'B3'];


    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        final user = context.watch<User>();

        return Scaffold(
            appBar: AppBar(
                title: const Text('Add Waste'),
            ),
            drawer: const GlobalDrawer(),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(top: 7, left: 15, bottom: 7, right: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat('yMd').format(_dateTime)),
                              IconButton(
                                icon: const Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2099),
                                  ).then(
                                    (date) => setState(
                                      () => _dateTime = date!,
                                    ),
                                  );
                                },
                              ),
                            ]),
                      ),
                      Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Example: 081234567890",
                                labelText: "Telephone Number",
                                icon: const Icon(Icons.call),
                                // Menambahkan circular border agar lebih rapi
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                ),
                            ),
                            // Menambahkan behavior saat nama diketik 
                            onChanged: (String? value) {
                                setState(() {
                                    _contact = value!;
                                });
                            },
                            // Menambahkan behavior saat data disimpan
                            onSaved: (String? value) {
                                setState(() {
                                    _contact = value!;
                                });
                            },
                            // Validator sebagai validasi form
                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return 'Nomor tidak boleh kosong!';
                                }
                                return null;
                            },
                        ),
                    ),
                    Padding(
                      // Menggunakan padding sebesar 8 pixels
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Address",
                              icon: const Icon(Icons.home),
                              // Menambahkan circular border agar lebih rapi
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                              ),
                          ),
                          // Menambahkan behavior saat nama diketik 
                          onChanged: (String? value) {
                              setState(() {
                                  _address = value!;
                              });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                              setState(() {
                                  _address = value!;
                              });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                  return 'Alamat tidak boleh kosong!';
                              }
                              return null;
                          },
                      ),
                  ),
                  DropdownButton(
                    value: _pilihan,
                    hint: const Text("Type"),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    borderRadius: BorderRadius.circular(15.0),
                    items: _listPilihan.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                        );
                    }).toList(),
                    onChanged: (String? newValue) {
                        setState(() {
                            _pilihan = newValue!;
                        });
                    },
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                  ), onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      const url = '$endpointDomain/bank/createbank_flutter/';
                      final response = await request.post(url, {
                        'user' :  user.toString(),
                        'tanggal': DateFormat("yyyy-MM-dd").format(_dateTime),
                        'kontak': _contact.toString(),
                        'alamat': _address.toString(),
                        'jenis': _pilihan.toString(),
                      });
                      print(response);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Waste added."),
                      ));
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const BankSampahFormPage()) 
                      );
                    }
                  },
                  child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                  )
                  )
                    ],
                  ),
                ),
            ),
            )
        );
    }
}