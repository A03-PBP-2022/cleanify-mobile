// To parse this JSON data, do
//
//     final bankSampah = bankSampahFromJson(jsonString);

import 'dart:convert';

List<BankSampah> bankSampahFromJson(String str) => List<BankSampah>.from(json.decode(str).map((x) => BankSampah.fromJson(x)));

String bankSampahToJson(List<BankSampah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankSampah {
    BankSampah({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory BankSampah.fromJson(Map<String, dynamic> json) => BankSampah(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.user,
        required this.jenis,
        required this.alamat,
        required this.tanggal,
        required this.kontak,
    });

    int user;
    String jenis;
    String alamat;
    DateTime tanggal;
    String kontak;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        jenis: json["jenis"],
        alamat: json["alamat"],
        tanggal: DateTime.parse(json["tanggal"]),
        kontak: json["kontak"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "jenis": jenis,
        "alamat": alamat,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "kontak": kontak,
    };
}
