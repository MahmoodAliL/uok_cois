import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uok_cois/constants.dart';
import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/view/components/post_img_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Function onPressed;

  const PostWidget({@required this.post, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      highlightColor: Colors.transparent,
      child: Ink(
        padding: const EdgeInsets.all(16),
        child: post.type == PostType.News
            ? buildNewsLayout(context)
            : buildAdsLayout(context),
      ),
    );
  }

  Widget buildAdsLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PostImage(
              postType: post.type,
              url: post.imgUrl,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: buildPostTitle(context),
            )
          ],
        ),
        const SizedBox(height: 8.0),
        buildBottomInfo(),
      ],
    );
  }

  Widget buildNewsLayout(BuildContext context) {
    return Column(
      children: [
        PostImage(
          postType: post.type,
          url: post.imgUrl,
        ),
        const SizedBox(height: 8.0),
        buildPostTitle(context),
        const SizedBox(height: 8.0),
        buildBottomInfo(),
      ],
    );
  }

  Text buildPostTitle(BuildContext context) {
    return Text(
      post.title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget buildBottomInfo() {
    return Row(
      children: [
        Icon(
          post.type == PostType.News
              ? Icons.article_rounded
              : Icons.notifications,
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
        Text('${getPostTypeName()} . ${post.date}'),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.black54,
          ),
          onPressed: () {
            Share.share(
                '${post.link}\n تم المشاركة من تطبيق UOK COIS يمكن تحميل التطبيق من الرابط دناة',
                subject: post.title);
          },
        ),
      ],
    );
  }

  String getPostTypeName() {
    return post.type == PostType.News ? 'اخر الاخبار' : 'الاعلانات';
  }
}
