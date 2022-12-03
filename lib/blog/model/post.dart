import 'package:cleanify/blog/consts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
    Posts({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Post> results;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Post>.from(json["results"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Post {
    Post({
        required this.pk,
        required this.author,
        required this.title,
        required this.content,
        required this.createdTimestamp,
        required this.modifiedTimestamp,
    });

    int pk;
    Author author;
    String title;
    String content;
    DateTime createdTimestamp;
    DateTime modifiedTimestamp;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        pk: json["pk"],
        author: Author.fromJson(json["author"]),
        title: json["title"],
        content: json["content"],
        createdTimestamp: DateTime.parse(json["created_timestamp"]),
        modifiedTimestamp: DateTime.parse(json["modified_timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "author": author.toJson(),
        "title": title,
        "content": content,
        "created_timestamp": createdTimestamp.toIso8601String(),
        "modified_timestamp": modifiedTimestamp.toIso8601String(),
    };
}

class Author {
    Author({
        required this.username,
        required this.nama,
    });

    String username;
    String nama;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json["username"],
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "nama": nama,
    };
}
Future<List<Post>> fetchBlogPostIndex(int pageKey) async {

  var url = Uri.parse('$endpointDomain/blog/api2/posts');

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

  final data = postsFromJson(utf8.decode(response.bodyBytes)).results;

  return data;
}

Future<Post> fetchPost(int postId) async {
  var url = Uri.parse('$endpointDomain/blog/api2/posts/$postId');

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
