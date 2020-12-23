import 'package:uok_cois/constants.dart';

class PostListResponse {
  final List<Post> posts;

  PostListResponse({this.posts});

  factory PostListResponse.fromJson(List<dynamic> json) {
    var posts = json.map((e) => Post.fromJson(e)).toList();
    return PostListResponse(posts: posts);
  }
}

class Post {
  static const _dateTimeSeparator = 'T';

  final int id;
  final String title;
  final String date;
  final String imgUrl;
  final String link;
  final PostType type;

  Post({this.id, this.title, this.date, this.imgUrl, this.link, this.type});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: _getPostTitle(json['title']['rendered']),
      date: _getPostDateOnlyFromPostDateTime(json['date']),
      type: _getPostTypeFromCategories(json['categories']),
      link: json['link'],
      imgUrl: json['jetpack_featured_media_url'],
    );
  }

  static PostType _getPostTypeFromCategories(List<dynamic> json) {
    List<int> categories = json.cast<int>();
    return categories.contains(adsCategoryId) ? PostType.ads : PostType.news;
  }

  static String _getPostDateOnlyFromPostDateTime(String date) {
    return date.split(_dateTimeSeparator).first;
  }

  static String _getPostTitle(String title) {
    return title.replaceAll('&#8211;', '-');
  }
}
