import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:cleanify/blog/model/comment.dart';

class CommentItem extends StatelessWidget {

  final Comment comment;
  final ValueChanged<Comment> deleteComment;
  final bool canDelete;
  final bool canChange;

  const CommentItem(this.comment, this.deleteComment, {
    super.key, 
    required this.canDelete,
    required this.canChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              // direction: Axis.horizontal,
              // crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceBetween,
              spacing: 5,
              runSpacing: 5,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        comment.author.username,
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
                            TextSpan(text: " ${DateFormat("dd MMMM y").format(comment.createdTimestamp)}"),
                          ]
                        )
                      ),
                    )
                  ],
                ),
                if (canChange || canDelete) PopupMenuButton<String>(
                  // Callback that sets the selected popup menu item.
                  onSelected: (String item) {
                    if (item == "delete") {
                      deleteComment(comment);
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    if (canDelete) const PopupMenuItem(
                      value: "delete",
                      child: Text('Delete'),
                    ),
                  ]
                ),
              ],
            ),
            MarkdownBody(
              data: comment.content,
            ),
          ],
        )
      ),
    );
  }
}

