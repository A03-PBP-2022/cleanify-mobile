// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:cleanify/laporsampah/model/laporan.dart';
import 'package:cleanify/laporsampah/page/form_report.dart';
import 'package:intl/intl.dart';

fetchData() async {
  List<Report> reports = [];
  const url = 'https://cleanifyid.up.railway.app/report/json/';
  try {
    print('hiawal');
    final response = await http.get(Uri.parse(url));
    print('hikedua');
    // print(response);
    final extractedData = jsonDecode(response.body); //masalah nya disini
    print('hi');
    for (var report in extractedData) {
      Fields fields = Fields(
        date: report["fields"]["date"],
        location: report["fields"]["location"],
        urgency: report["fields"]["urgency"],
        description: report["fields"]["description"],
        contact: report["fields"]["contact"],
      );
      print('hi2');
      Report reportModel =
          Report(model: report["model"], pk: report["pk"], fields: fields);
      print('hi3');
      reports.add(reportModel);
      print('hi4');
    }

    return reports;
  } catch (error) {
    print(error);
    return error;
  }
}

class ListReportPage extends StatefulWidget {
  const ListReportPage({Key? key}) : super(key: key);

  @override
  _ListReportPageState createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  List<Report> reports = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final report = await fetchData();

    setState(() {
      reports = report;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Report List'),
      ),
      drawer: GlobalDrawer(),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: reports.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        tileColor: Colors.grey.shade300,
                        title: Text((reports[index].fields)!.location),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reports[index].fields.urgency,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${reports[index].fields.contact} - ${reports[index].fields.date}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10),
                              Text(
                                reports[index].fields.description,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              ]);
            }),
      ])),
    );
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
