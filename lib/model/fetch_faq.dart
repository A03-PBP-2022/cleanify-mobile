import 'dart:convert';
import 'package:cleanify/model/faq_model.dart';
import 'package:http/http.dart' as http;


Future<List<Faq>> fetchFaq() async {
    var url = Uri.parse('https://cleanifyid.up.railway.app/faq/json/');
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
    List<Faq> listFaq = [];
    for (var d in data) {
    if (d != null) {
        listFaq.add(Faq.fromJson(d));
    }
    }

    return listFaq;
}
