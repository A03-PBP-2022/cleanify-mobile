import 'dart:convert';
import 'package:http/http.dart' as http;

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.model,
    required this.pk,
    required this.fields,
    required this.perms,
  });

  String model;
  int pk;
  CommentFields fields;
  Perms perms;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        model: json["model"],
        pk: json["pk"],
        fields: CommentFields.fromJson(json["fields"]),
        perms: Perms.fromJson(json["perms"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
        "perms": perms.toJson(),
      };
}

class CommentFields {
  CommentFields({
    required this.author,
    required this.content,
    required this.post,
    required this.createdTimestamp,
    required this.modifiedTimestamp,
  });

  Author author;
  String content;
  int post;
  DateTime createdTimestamp;
  DateTime modifiedTimestamp;

  factory CommentFields.fromJson(Map<String, dynamic> json) => CommentFields(
        author: Author.fromJson(json["author"]),
        content: json["content"],
        post: json["post"],
        createdTimestamp: DateTime.parse(json["created_timestamp"]),
        modifiedTimestamp: DateTime.parse(json["modified_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "content": content,
        "post": post,
        "created_timestamp": createdTimestamp.toIso8601String(),
        "modified_timestamp": modifiedTimestamp.toIso8601String(),
      };
}

class Author {
  Author({
    required this.username,
    required this.name,
  });

  String username;
  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json["username"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
      };
}

class Perms {
  Perms({
    required this.edit,
    required this.delete,
  });

  bool edit;
  bool delete;

  factory Perms.fromJson(Map<String, dynamic> json) => Perms(
        edit: json["edit"],
        delete: json["delete"],
      );

  Map<String, dynamic> toJson() => {
        "edit": edit,
        "delete": delete,
      };
}

Future<List<Comment>> fetchComments(int postId, int pageKey) async {
  // var url = Uri.parse('http://127.0.0.1:8000/blog/api/post/$postId/comment?page=$pageKey');
  var url = Uri.parse('https://cleanifyid.up.railway.app/blog/api/post/$postId/comment?page=$pageKey');

  final response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to load list.");
  }

  final data = commentFromJson(utf8.decode(response.bodyBytes));

  return data;
}
