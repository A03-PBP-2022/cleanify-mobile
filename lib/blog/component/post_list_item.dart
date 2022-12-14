import 'dart:math';
import 'package:cleanify/blog/component/markdown_style.dart';
import 'package:cleanify/blog/model/post.dart';
import 'package:cleanify/blog/page/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const WidgetSpan(child: Icon(
                        Icons.calendar_today,
                        size: 16,
                      )),
                      TextSpan(text: " ${DateFormat("dd MMMM y").format(post.createdTimestamp)} • "),
                      const WidgetSpan(child: Icon(
                        Icons.person,
                        size: 16,
                      )),
                      // Dapatkan juga orangnya
                      TextSpan(text: " ${post.author.username}"),
                    ],
                  ),
                ),
              ),
             MarkdownBody(
                data: post.content.substring(0, min(120, post.content.length)),
                styleSheet: blogMarkdownStyle,
              ),
            ],
          )
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage(postId: post.pk)),
          );
        },
      ),
    );
  }
}

