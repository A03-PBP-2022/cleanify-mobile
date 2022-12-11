import 'dart:convert';
import 'package:cleanify/laporsampah/model/laporan.dart';
import 'package:http/http.dart' as http;

Future<List<Laporan>> fetchMyWatchList() async {
    var url = Uri.parse('https://cleanifyid.up.railway.app/report/json/');
    var response = await http.get(
    url,
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
    },
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Laporan> listLaporan = [];
    for (var d in data) {
      if (d != null) {
          listLaporan.add(Laporan.fromJson(d));
        }
    }
    return listLaporan;
}