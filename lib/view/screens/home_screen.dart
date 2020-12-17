import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:http/http.dart';
import 'package:uok_cois/blocs/post_bloc.dart';
import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/networking/api_response.dart';
import 'package:uok_cois/view/components/drawer_widget.dart';
import 'package:uok_cois/view/components/error_widget.dart';
import 'package:uok_cois/view/components/loading_item_widget.dart';
import 'package:uok_cois/view/components/loading_widget.dart';
import 'package:uok_cois/view/components/post_widget.dart';
import 'package:uok_cois/view/ui_helper.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firebaseMessaging = FirebaseMessaging();

  ScrollController _scrollController;
  List<Post> _posts = [];

  PostBloc _postBloc;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _firebaseMessagingConfigure();

    _scrollController = ScrollController()..addListener(_scrollListener);
    _postBloc = PostBloc();
  }

  _firebaseMessagingConfigure() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        String title = message['notification']['title'] ?? 'null title';
        String body = message['notification']['body'] ?? 'null body';
        _showNotificationDialog(title, body);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        String title = message['notification']['title'] ?? 'null title';
        String body = message['notification']['body'] ?? 'null body';
        _showNotificationDialog(title, body);
      },
    );
  }

  void _showNotificationDialog(String title, String body) {
    showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(body),
          ),
          actions: [
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController = ScrollController()..removeListener(_scrollListener);
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: StreamBuilder<ApiResponse<List<Post>>>(
        stream: _postBloc.postListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _isLoading = false;

            switch (snapshot.data.status) {
              case Status.loading:
                return _onLoading();
                break;

              case Status.completed:
                return _onCompleted(snapshot);
                break;
              case Status.error:
                return _onError(snapshot);
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

  Widget _onCompleted(AsyncSnapshot<ApiResponse<List<Post>>> snapshot) {
    var newPosts = snapshot.data.data;
    this._posts.addAll(newPosts);
    return _buildListView();
  }

  Widget _onError(AsyncSnapshot<ApiResponse<List<Post>>> snapshot) {
    return _shouldShowListView()
        ? _buildListView()
        : ErrorWidget(
            errorMessage: snapshot.data.message,
            onRetry: () {
              _postBloc.fetchPostList();
            },
          );
  }

  bool _shouldShowListView() {
    return _posts.isNotEmpty;
  }

  ListView _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        if (index == (_posts.length - 1) && _isLoading) {
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
    );
  }

  void _scrollListener() async {
    ScrollPosition position = _scrollController.position;
    if (position.extentAfter < 500 && !_isLoading) {
      setState(() {
        _posts.add(null);
        _isLoading = true;
      });

      print('start waiting');
      await _postBloc.fetchPostList();
      print('end waiting');

      setState(() {
        _posts.removeLast();
        _isLoading = false;
      });
    }
  }
}
