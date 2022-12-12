// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:cleanify/consts.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Widget>> fetchData(request) async {
  List<Widget> result = [];
  const url = '$endpointDomain/report/locations/';
  final response = await request.get(url);
  final extractedData = jsonDecode(
      (response as Map<String, dynamic>)['locations']); 
  for (var location in extractedData) {
    result.add(buildProjectCard(
        date: location['fields']['date'],
        location: location['fields']['location'].toString(),
        urgency: location['fields']['urgency'].toString(),
        description: location['fields']['description'].toString()));
  }
  return result;
}

class ListReportPage extends StatefulWidget {
  const ListReportPage({Key? key}) : super(key: key);

  @override
  _ListReportPageState createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  List<Widget> reports = [];
  late Future<List<Widget>> data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    getData(request);
    return Scaffold(
        resizeToAvoidBottomInset: false, 
        appBar: AppBar(
          title: const Text('Report List'),
        ),
        drawer: GlobalDrawer(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / (4 / 3),
              child:
                  ListView(controller: ScrollController(), children: reports),
            ),
          ],
        ));
  }
  
  getData(request) async {
    Future<List<Widget>> data;
    data = fetchData(request);
    reports = await data;
    setState(() {});
  }
}

Widget buildProjectCard({
  required String date,
  required String location,
  required String urgency,
  required String description,
}) {
  return Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(width: 1.0, color: Color.fromARGB(255, 48, 100, 38)),
        left: BorderSide(width: 1.0, color: Color.fromARGB(255, 48, 100, 38)),
        right: BorderSide(width: 1.0, color: Color.fromARGB(255, 48, 100, 38)),
        bottom: BorderSide(width: 1.0, color: Color.fromARGB(255, 48, 100, 38)),
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 250,
                  child: Text(
                    location,
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    left: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    right: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    bottom: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month),
                    Text(date),
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    left: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    right: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                    bottom: BorderSide(
                        width: 2.0, color: Color.fromARGB(255, 74, 108, 75)),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Text(" Urgency level: " + urgency + "/5 "),
                  ],
                )),
          ]),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
