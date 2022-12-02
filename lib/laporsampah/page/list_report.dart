// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:cleanify/laporsampah/model/laporan.dart';
import 'package:cleanify/laporsampah/page/form_report.dart';
import 'package:intl/intl.dart';

class ListReportPage extends StatefulWidget {
  const ListReportPage({Key? key}) : super(key: key);

  @override
  _ListReportPageState createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report List'),
        ),
        drawer: GlobalDrawer(),
        body: Form(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  for (var data in listData)
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          child: ListTile(
                            tileColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            title: Text(data.location.toString(),
                                style: TextStyle(fontSize: 20)),
                            subtitle: Text(data.urgency.toString() +
                                "\n" +
                                data.date.toString() + "\n" +
                                data.description.toString() + "\n" +
                                data.contact.toString()),
                          ),
                        )),
                ],
              ),
            ),
          ),
        ));
  }
}

class Details {
  String? date;
  String? location;
  String? urgency;
  String? description;
  String? contact;

  Details(String date, String location, String urgency, String description,
      String contact) {
    this.date = date;
    this.location = location;
    this.urgency = urgency;
    this.description = description;
    this.contact = contact;
  }
}
