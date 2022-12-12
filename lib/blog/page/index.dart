import 'package:cleanify/blog/component/post_list_item.dart';
import 'package:cleanify/blog/model/post.dart';
import 'package:cleanify/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BlogIndexPage extends StatefulWidget {
  const BlogIndexPage({super.key});
  final String title = 'Blog';

  @override
  State<BlogIndexPage> createState() => _BlogIndexPageState();
}

class _BlogIndexPageState extends State<BlogIndexPage> {
  static const _pageSize = 10;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  // fetchBlogPostIndex
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await fetchBlogPostIndex(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const GlobalDrawer(),
      body: PagedListView<int, Post>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, item, index) => 
          PostListItem(
            post: item
          ),
        ),
      ),
    );
  }
}
