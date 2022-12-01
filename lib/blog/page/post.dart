import 'package:cleanify/blog/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.postId});

  final String title = 'Post';
  final int postId;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<Post> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(widget.title),
      ),
      body: FutureBuilder<Post>(
        future: futurePost,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "${snapshot.data!.fields.title}",
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
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
                              TextSpan(text: " ${DateFormat("dd MMMM y").format(snapshot.data!.fields.createdTimestamp)} • "),
                              const WidgetSpan(child: Icon(
                                Icons.person,
                                size: 16,
                              )),
                              // Dapatkan juga orangnya
                              TextSpan(text: " ${snapshot.data!.fields.author}"),
                            ]
                          )
                        ),
                      ),
                      MarkdownBody(
                        data: snapshot.data!.fields.content,
                      ),
                    ],
                  ),
                )
              ]
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}

