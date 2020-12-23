import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:uok_cois/blocs/post_bloc.dart';
import 'package:uok_cois/constants.dart';
import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/networking/api_response.dart';
import 'package:uok_cois/view/screens/posts/widgets/post_widget.dart';
import 'package:uok_cois/view/ui_helper.dart';
import 'package:uok_cois/view/widgets/error_widget.dart';
import 'package:uok_cois/view/widgets/loading_item_widget.dart';
import 'package:uok_cois/view/widgets/loading_widget.dart';

class PostsScreen extends StatefulWidget {
  final PostType postType;

  const PostsScreen({this.postType});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Post> _posts = [];

  PostBloc _postBloc;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    print('initState');
    _postBloc = PostBloc();
    _postBloc.fetchPostList(postType: widget.postType);
  }

  @override
  void dispose() {
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ApiResponse<List<Post>>>(
        stream: _postBloc.postListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.loading:
                return _onLoading();
                break;

              case Status.completed:
                return _onCompleted(snapshot.data.data);
                break;

              case Status.error:
                return _onError(snapshot.data.message);
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _onLoading() {
    _isLoading = true;
    return _shouldShowListView() ? _buildListView() : LoadingWidget();
  }

  Widget _onCompleted(List<Post> newPosts) {
    _posts = newPosts;
    _isLoading = false;
    return _buildListView();
  }

  Widget _onError(String message) {
    return _shouldShowListView()
        ? _buildListView()
        : ErrorWidget(
            onRetry: () {
              _postBloc.fetchPostList();
            },
          );
  }

  bool _shouldShowListView() {
    return _posts.isNotEmpty;
  }

  Widget _buildListView() {
    print('_buildListView _postLength: ${_posts.length}');
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (_isLoading) {
          return false;
        }
        var metrics = scrollInfo.metrics;
        var triggerFetchMoreSize = metrics.maxScrollExtent * 0.8;
        if (metrics.pixels >= triggerFetchMoreSize) {
          print('called load more');
          _onLoadingMore();
        }

        return false;
      },
      child: ListView.builder(
        itemCount: _isLoading ? _posts.length + 1 : _posts.length,
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return LoadingItemWidget();
          }

          var post = _posts[index];
          return Column(
            children: [
              PostWidget(
                post: post,
                onPressed: () {
                  Helper.launchBrowser(context, post.link);
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  void _onLoadingMore() async {
    _updateLoadingState(true);
    print('wating data');
    await _postBloc.fetchPostList(postType: widget.postType);
    print('data fetched');
    _updateLoadingState(false);
  }

  void _updateLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
