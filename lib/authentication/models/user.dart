import 'dart:convert';
import 'dart:core';

class User {
  String? email = "";
  String? username = "";
  String? fullName = "";
  String? phoneNumber = "";
  String? address = "";


  // bool? is_user;
  // bool? is_crew;

  User({
    this.email,
    this.username,
    this.fullName,
    this.phoneNumber,
    this.address,

    // this.is_user,
    // this.is_crew,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        email: data["data"]["data"]["email"],
        username: data["data"]["data"]["username"],
        fullName: data["data"]["data"]["name"],
        phoneNumber: data["data"]["data"]["phoneNumber"],
        address: data["data"]["data"]["address"],
        // is_user: data["data"]["data"]["is_user"],
        // is_crew: data["data"]["data"]["is_crew"],
    );
  }
}
