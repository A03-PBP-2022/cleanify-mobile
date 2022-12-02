// To parse this JSON data, do
//
//     final laporan = laporanFromJson(jsonString);

import 'dart:convert';

List<Laporan> laporanFromJson(String str) => List<Laporan>.from(json.decode(str).map((x) => Laporan.fromJson(x)));

String laporanToJson(List<Laporan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
    Report({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Laporan fields;

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        model: json["model"],
        pk: json["pk"],
        fields: Laporan.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Laporan {
    Laporan({
        required this.date,
        required this.location,
        required this.urgency,
        required this.description,
        required this.contact,
    });

    String date;
    String location;
    String urgency;
    String description;
    String contact;

    factory Laporan.fromJson(Map<String, dynamic> json) => Laporan(
        date: json["date"],
        location: json["location"],
        urgency: json["urgency"],
        description: json["description"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "location": location,
        "urgency": urgency,
        "description": description,
        "contact": contact,
    };
}
