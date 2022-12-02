import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:cleanify/blog/model/comment.dart';

class CommentItem extends StatelessWidget {

  final Comment comment;

  const CommentItem(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(
                comment.fields.author.username,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(child: Icon(
                      Icons.calendar_today,
                      size: 16,
                    )),
                    TextSpan(text: " ${DateFormat("dd MMMM y").format(comment.fields.createdTimestamp)}"),
                  ]
                )
              ),
            ),
            MarkdownBody(
              data: comment.fields.content,
            ),
          ],
        )
      ),
    );
  }
}
