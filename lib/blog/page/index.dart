import 'dart:math';
import 'package:cleanify/blog/models/post.dart';
import 'package:cleanify/blog/page/post.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class BlogIndexPage extends StatefulWidget {
  const BlogIndexPage({super.key});
  final String title = 'Blog';

  @override
  State<BlogIndexPage> createState() => _BlogIndexPageState();
}

class _BlogIndexPageState extends State<BlogIndexPage> {
  late Future<List<Post>> futurePostIndex;

  @override
  void initState() {
    super.initState();
    futurePostIndex = fetchBlogPostIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const GlobalDrawer(),
      body: FutureBuilder<List<Post>>(
        future: futurePostIndex,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Card(
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
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "${snapshot.data![index].fields.title}",
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
                                TextSpan(text: " ${DateFormat("dd MMMM y").format(snapshot.data![index].fields.createdTimestamp)} • "),
                                const WidgetSpan(child: Icon(
                                  Icons.person,
                                  size: 16,
                                )),
                                // Dapatkan juga orangnya
                                TextSpan(text: " ${snapshot.data![index].fields.author}"),
                              ]
                            )
                          ),
                        ),
                       MarkdownBody(
                          data: snapshot.data![index].fields.content.substring(0, min(120, snapshot.data![index].fields.content.length as int)),
                        ),
                      ],
                    )
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostPage(postId: snapshot.data![index].pk)),
                    );
                  },
                ),
              ),
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

