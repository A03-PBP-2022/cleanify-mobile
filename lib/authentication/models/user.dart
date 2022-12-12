// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.pk,
        this.email,
        this.username,
        this.name,
        this.phoneNumber,
        this.address,
        this.role = 'anonymous',
        this.permissions = const [],
    });

    int? pk;
    String? email;
    String? username;
    String? name;
    String? phoneNumber;
    String? address;
    String role = 'anonymous';
    List<String> permissions;

    factory User.fromJson(Map<String, dynamic> json) => User(
        pk: json["pk"],
        email: json["email"],
        username: json["username"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        role: json["role"],
        permissions: List<String>.from(json["permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "email": email,
        "username": username,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "role": role,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
    };
}
