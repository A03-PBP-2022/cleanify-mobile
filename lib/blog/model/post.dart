import 'dart:convert';
import 'package:http/http.dart' as http;

List<Post> postsFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postsToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  PostFields fields;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        model: json["model"],
        pk: json["pk"],
        fields: PostFields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class PostFields {
  PostFields({
    required this.author,
    required this.title,
    required this.content,
    required this.createdTimestamp,
    required this.modifiedTimestamp,
  });

  int author;
  String title;
  String content;
  DateTime createdTimestamp;
  DateTime modifiedTimestamp;

  factory PostFields.fromJson(Map<String, dynamic> json) => PostFields(
        author: json["author"],
        title: json["title"],
        content: json["content"],
        createdTimestamp: DateTime.parse(json["created_timestamp"]),
        modifiedTimestamp: DateTime.parse(json["modified_timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "content": content,
        "created_timestamp": createdTimestamp.toIso8601String(),
        "modified_timestamp": modifiedTimestamp.toIso8601String(),
      };
}

Future<List<Post>> fetchBlogPostIndex() async {
  var url = Uri.parse('http://127.0.0.1:8000/blog/api/post');
  // var url = Uri.parse('https://cleanifyid.up.railway.app/blog/api/post');

  final response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode != 200) {
    throw Exception("Failed on getting data.");
  }

  final data = postsFromJson(utf8.decode(response.bodyBytes));

  return data;
}

Future<Post> fetchPost(int postId) async {
  // var url = Uri.parse('http://127.0.0.1:8000/blog/api/post/$postId');
  var url = Uri.parse('https://cleanifyid.up.railway.app/blog/api/post/$postId');

  final response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode != 200) {
    throw Exception("Failed on getting data.");
  }

  final data = postFromJson(utf8.decode(response.bodyBytes));

  return data;
}
