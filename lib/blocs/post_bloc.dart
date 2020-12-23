import 'dart:async';

import 'package:uok_cois/constants.dart';
import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/networking/api_response.dart';
import 'package:uok_cois/respository/PostRepository.dart';

class PostBloc {
  PostRepository _postRepository;
  StreamController _postListController;

  StreamSink<ApiResponse<List<Post>>> get postListSink =>
      _postListController.sink;

  Stream<ApiResponse<List<Post>>> get postListStream =>
      _postListController.stream;

  int _page = 1;
  List<Post> _posts = [];

  PostBloc() {
    _postListController = StreamController<ApiResponse<List<Post>>>();
    _postRepository = PostRepository();
  }

  fetchPostList({bool refresh = false, PostType postType}) async {
    if (refresh) {
      _page = 1;
    }
    postListSink.add(ApiResponse.loading('Loading'));

    try {
      List<Post> posts =
          await _postRepository.fetchPostList(page: _page, postType: postType);
      _posts.addAll(posts);

      postListSink.add(ApiResponse.completed(_posts));
      _page++;
    } catch (e) {
      postListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _postListController.close();
  }
}
