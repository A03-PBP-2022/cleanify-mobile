import 'package:cleanify/consts.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));

String commentsToJson(Comments data) => json.encode(data.toJson());

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comments {
    Comments({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    int count;
    dynamic next;
    dynamic previous;
    List<Comment> results;

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Comment>.from(json["results"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Comment {
    Comment({
        required this.pk,
        required this.author,
        required this.content,
        required this.post,
        required this.createdTimestamp,
        required this.modifiedTimestamp,
    });

    int pk;
    Author author;
    String content;
    int post;
    DateTime createdTimestamp;
    DateTime modifiedTimestamp;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        pk: json["pk"],
        author: Author.fromJson(json["author"]),
        content: json["content"],
        post: json["post"],
        createdTimestamp: DateTime.parse(json["created_timestamp"]),
        modifiedTimestamp: DateTime.parse(json["modified_timestamp"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "author": author.toJson(),
        "content": content,
        "post": post,
        "created_timestamp": createdTimestamp.toIso8601String(),
        "modified_timestamp": modifiedTimestamp.toIso8601String(),
    };
}

class Author {
    Author({
        required this.pk,
        required this.username,
        required this.name,
    });

    int pk;
    String username;
    String name;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        pk: json["pk"],
        username: json["username"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "name": name,
    };
}

Future<List<Comment>> fetchComments(int postId, int pageKey) async {

  var url = Uri.parse('$endpointDomain/blog/api2/posts/$postId/comments?page=$pageKey');

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

  final data = commentsFromJson(utf8.decode(response.bodyBytes)).results;

  return data;
}

Future<Comment> fetchComment(int postId, int commentId) async {

  var url = Uri.parse('$endpointDomain/blog/api2/posts/$postId/comments/$commentId');

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
