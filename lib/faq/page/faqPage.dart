import 'package:flutter/material.dart';
import 'package:cleanify/core/drawer.dart';
// ignore: unused_import
import 'package:cleanify/faq/page/faqDetail.dart';
import 'package:cleanify/faq/model/fetch_faq.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqState();
}

class _FaqState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Frequently Asked Questions'),
        ),
        drawer: const GlobalDrawer(),
        body: FutureBuilder(
            future: fetchFaq(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Belum ada FAQ",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(5.0),
                                color:Colors.green,
                                shadowColor: Colors.blueGrey,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FAQDetailPage(
                                            faqs : snapshot.data![index],
                                          ),
                                        ),
                                    );
                                  },
                                  title:
                                      Text(snapshot.data![index].fields.question, style: const TextStyle(
                                color: Colors.white)),
                                ),
                              ),
                          ),
                    );
                }
              }
            }));
  }
}