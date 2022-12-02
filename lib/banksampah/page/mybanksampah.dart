import 'package:cleanify/banksampah/model/model_banksampah.dart';
import 'package:cleanify/banksampah/page/itembanksampah.dart';
import 'package:cleanify/banksampah/page/listbanksampah.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/formbanksampah.dart';
import 'package:cleanify/banksampah/page/fetchbanksampah.dart';

class BankSampahJson extends StatefulWidget {
    const BankSampahJson({Key? key}) : super(key: key);

    @override
    _BankSampahJsonState createState() => _BankSampahJsonState();
}

class _BankSampahJsonState extends State<BankSampahJson> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('My Bank Sampah'),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  // Route menu ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              ListTile(
                title: const Text('List Bank Sampah'),
                onTap: () {
                  // Route menu ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyBankSampahPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Form Bank Sampah'),
                onTap: () {
                  // Route menu ke halaman utama
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyFormPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('My Bank Sampah'),
                onTap: () {
                  // Route menu ke halaman utama
                  Navigator.pop(
                    context);
                },
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: fetchMyWatchList(),
          builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
              } else {
              if (!snapshot.hasData) {
                  return Column(
                  children: const [
                      Text(
                      "Tidak ada Bank Sampah :(",
                      style: TextStyle(
                          color: Color(0xff59A5D8),
                          fontSize: 20),
                      ),
                      SizedBox(height: 8),
                  ],
                  );
              } else {
                  return ListView.separated(
                      padding: const EdgeInsets.all(20.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index){
                      return ListTile(
                      tileColor: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                          color: Color.fromARGB(255, 51, 53, 51),
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                      ),
                      title: Text(
                              "${snapshot.data![index].fields.title}",
                              style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              ),
                          ),
                      onTap: () {
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  ItemBankSampah(
                            user: snapshot.data![index].fields.user,
                            jenis: snapshot.data![index].fields.jenis,
                            alamat: snapshot.data![index].fields.alamat,
                            tanggal: snapshot.data![index].fields.tanggal,
                            kontak: snapshot.data![index].fields.kontak,
                          ))
                          );
                      },
                      );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                  )
                  );
              }
              }
          }
      )
    );
  }
}