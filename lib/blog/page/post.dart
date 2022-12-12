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

  late bool _isLastPage = false;
  late int _pageNumber = 1;
  late bool _error = false;
  late bool _loading = true;
  final int _numberOfPostsPerRequest = 10;
  final List<Comment> _comments = [];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newCommentController = TextEditingController();
  late CookieRequest request;
  late User user;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost(widget.postId);
    fetchCommentsState();
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

    request = context.watch<CookieRequest>();
    user = context.watch<User>();

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
                              controller: _newCommentController,
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
                                      'content': _newCommentController.text,
                                    });
                                    final newComment = await fetchComment(widget.postId, response['pk']);
                                    ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                        content:
                                          Text("Comment sent!"),
                                        ));
                                    _newCommentController.clear();
                                    setState(() {
                                      _comments.insert(0, newComment);
                                    });
                                  },
                                  child: const Text('Send'),
                                ),
                              ],
                            ), 
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: commentsListWidget(),
                      )
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

  void _deleteComment(Comment comment) async {
    dynamic response = await request.post('$endpointDomain/blog/api/post/${widget.postId}/comment/${comment.pk}/delete', {});
    if (response['status'] != 'OK') {
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(
          content: Text("Comment failed to be deleted! Try again later."),
        ));
      return;
    }
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(
        content: Text("Comment deleted!"),
      ));
    setState(() {
      _comments.remove(comment);
    });
  }

  Widget commentsListWidget() {
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
      } else {
        return Text("No comments.");
      }
    }

    List<Widget> children = [];

    for (var comment in _comments) {
      bool isSelf = comment.author.pk == user.pk;
      children.add(CommentItem(
        comment, _deleteComment, 
        canChange: isSelf && user.permissions.contains('change_self_comment') || user.permissions.contains('change_other_comment'),
        canDelete: isSelf && user.permissions.contains('delete_self_comment') || user.permissions.contains('delete_other_comment'), 
      ));
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

