import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/networking/api_helper.dart';

class PostRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<Post>> fetchPostList(int page) async {
    final response = await _apiHelper.get(
        'posts/wp/v2/posts/?rest_route=/wp/v2/posts&_fields=id,title,link,jetpack_featured_media_url,date,content,categories&categories=158,92&page=$page');
    return PostListResponse.fromJson(response).posts;
  }
}
