import 'package:cleanify/banksampah/page/list.dart';
import 'package:cleanify/banksampah/page/my.dart';
import 'package:cleanify/core/drawer.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cleanify/banksampah/model/banksampah.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/form.dart';
import 'package:cleanify/banksampah/page/fetch.dart';

class ItemBankSampah extends StatelessWidget {
    const ItemBankSampah(
      {super.key,
      required this.user,
      required this.jenis,
      required this.alamat,
      required this.tanggal,
      required this.kontak});

    final int user;
    final String jenis;
    final String alamat;
    final DateTime tanggal;
    final String kontak;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title: const Text('Item'),
        ),
        drawer: const GlobalDrawer(),
        body: Container(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: Text(user.toString() + '\n',
                      style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 24))),
                  Row(children: [
                      Text("Release Date: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(tanggal.toString().substring(0, 10), style: const TextStyle(fontSize: 18))
                    ]),
                  Row(children: [
                      Text("alamat: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(alamat.toString(), style: const TextStyle(fontSize: 18))
                    ]),
                  Row(children: [
                      Text("Status: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(user.toString(), style: const TextStyle(fontSize: 18)),
                    ]),
                  Text("kontak: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(kontak.toString(), style: const TextStyle(fontSize: 18)),
                ],
                )
        ),
        bottomNavigationBar: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 10,
                child: TextButton(
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
              )
            ),
    );
    }
}
