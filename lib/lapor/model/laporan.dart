// To parse this JSON data, do
//
//     final laporan = laporanFromJson(jsonString);

import 'dart:convert';

List<Fields> laporanFromJson(String str) => List<Fields>.from(json.decode(str).map((x) => Fields.fromJson(x)));

String laporanToJson(List<Fields> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
    Report({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Report.fromJson(Map<String, dynamic> json) => Report(
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
        required this.date,
        required this.location,
        required this.urgency,
        required this.description,
    });

    String date;
    String location;
    String urgency;
    String description;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        date: json["date"],
        location: json["location"],
        urgency: json["urgency"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "location": location,
        "urgency": urgency,
        "description": description,
    };
}
