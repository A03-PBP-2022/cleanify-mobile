import 'package:cleanify/banksampah/page/mybanksampah.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/formbanksampah.dart';

class MyBankSampahPage extends StatefulWidget {
    const MyBankSampahPage({super.key});

    @override
    State<MyBankSampahPage> createState() => _MyBankSampahPageState();
}

class ListBankSampah {
  DateTime? datetime;
  String? contact; 
  String? address;
  String? pilihan;
  
  ListBankSampah(DateTime datetime,String contact, String address, String pilihan) {
    this.datetime = datetime;
    this.contact = contact;
    this.address = address;
    this.pilihan = pilihan;
  }
}

class _MyBankSampahPageState extends State<MyBankSampahPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('List Bank Sampah'),
            ),
            drawer: const GlobalDrawer(),
            body: Form(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      for (var data in listData)
                      Padding(
                          // Menggunakan padding sebesar 8 pixels
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            child: ListTile(
                              tileColor: Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder( //<-- SEE HERE
                                side: BorderSide(width: 0.1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              title: Text(
                                data.pilihan.toString(),
                                style: TextStyle(
                                  fontSize: 20)
                              ),
                              subtitle: Text(data.contact.toString() + "\n" + data.datetime.toString()),
                              trailing: Text(data.address.toString()),
                            ),
                          )
                      ),
                  ],
                  ),
                ),
              ),
            )
        );
    }
}
