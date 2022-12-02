import 'package:cleanify/blog/component/post_list_item.dart';
import 'package:cleanify/blog/model/post.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';

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
              itemBuilder: (_, index) => PostListItem(
                post: snapshot.data![index]
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
