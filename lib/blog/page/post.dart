import 'package:cleanify/authentication/models/user.dart';
import 'package:cleanify/blog/component/markdown_style.dart';
import 'package:cleanify/consts.dart';
import 'package:cleanify/blog/model/comment.dart';
import 'package:cleanify/blog/model/post.dart';
import 'package:cleanify/blog/component/comment_item.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.postId});

  final String title = 'Post';
  final int postId;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late Future<Post> futurePost;

  late bool _isLastPage;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _numberOfPostsPerRequest = 10;
  late List<Comment> _comments;
  late ScrollController _scrollController;
  var _newComment = '';

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost(widget.postId);
    _pageNumber = 1;
    _comments = [];
    _isLastPage = false;
    _loading = true;
    fetchCommentsState();
    _error = false;
    _scrollController = ScrollController();
    _newComment = '';
  }

  Future<void> fetchCommentsState() async {
    try {
      List<Comment> commentList = await fetchComments(widget.postId, _pageNumber);
      if (mounted) {
        setState(() {
          _isLastPage = commentList.length < _numberOfPostsPerRequest;
          _loading = false;
          _pageNumber = _pageNumber + 1;
          _comments.addAll(commentList);
        });
      }
    } catch (e) {
      // print("error --> $e");
      if (mounted) {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final request = context.watch<CookieRequest>();
    final user = context.watch<User>();

    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if ((_scrollController.position.pixels > nextPageTrigger) && !_loading && !_error && !_isLastPage) {
        _loading = true;
        fetchCommentsState();
      }
    });

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
              controller: _scrollController,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          "${snapshot.data!.title}",
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700,
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
                              TextSpan(text: " ${DateFormat("dd MMMM y").format(snapshot.data!.createdTimestamp)} • "),
                              const WidgetSpan(child: Icon(
                                Icons.person,
                                size: 16,
                              )),
                              // Dapatkan juga orangnya
                              TextSpan(text: " ${snapshot.data!.author.username}"),
                            ]
                          )
                        ),
                      ),
                      MarkdownBody(
                        data: snapshot.data!.content,
                        styleSheet: blogMarkdownStyle
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: const Divider(),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: const Text(
                          "Comments",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (user.permissions.contains('add_comment')) Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (value) => {
                                setState(() {
                                  _newComment = value;
                                })
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(8),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white
                                  ),
                                  onPressed: () async {
                                    final response = await request.post('$endpointDomain/blog/api/post/${widget.postId}/comment/new', {
                                      'content': _newComment,
                                    });
                                    final newComment = await fetchComment(widget.postId, response['pk']);
                                    setState(() {
                                      _comments.insert(0, newComment);
                                    });
                                  },
                                  child: const Text('Create'),
                                ),
                              ],
                            ), 
                          ),
                        ],
                      ),
                      commentsList()
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

  Widget commentsList() {
    if (_comments.isEmpty) {
      if (_loading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
          )
        );
      } else if (_error) {
        return const Center(
            // child: errorDialog(size: 20)
        );
      }
    }

    List<Widget> children = [];

    for (var comment in _comments) {
      children.add(CommentItem(comment));
    } 

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}

