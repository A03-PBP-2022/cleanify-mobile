import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/banksampah/model/banksampah.dart';
import 'package:cleanify/banksampah/page/item.dart';
import 'package:cleanify/banksampah/page/list.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/core/home.dart';
import 'package:cleanify/banksampah/page/form.dart';
import 'package:cleanify/banksampah/page/fetch.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BankSampahJsonPage extends StatefulWidget {
    const BankSampahJsonPage({Key? key}) : super(key: key);

    @override
    _BankSampahJsonPageState createState() => _BankSampahJsonPageState();
}

class _BankSampahJsonPageState extends State<BankSampahJsonPage> {
    final _loginFormKey = GlobalKey<FormState>();
    bool isFailed = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final user = context.watch<User>();
    
    return Scaffold(
        appBar: AppBar(
            title: const Text('My Bank Sampah'),
        ),
        drawer: const GlobalDrawer(),
        body: FutureBuilder(
          future: fetchMyBankSampah(),
          builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
              } else {
              // make request from user
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