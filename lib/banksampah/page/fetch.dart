import 'dart:convert';
import 'package:cleanify/banksampah/model/banksampah.dart';
import 'package:http/http.dart' as http;

Future<List<BankSampah>> fetchMyBankSampah() async {
    var url = Uri.parse('https://cleanifyid.up.railway.app/bank/json/');
    var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object ToDo
    List<BankSampah> listMyBankSampah = [];
    for (var d in data) {
      if (d != null) {
          listMyBankSampah.add(BankSampah.fromJson(d));
        }
    }
    return listMyBankSampah;
}