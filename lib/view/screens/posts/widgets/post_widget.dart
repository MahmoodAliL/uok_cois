import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:uok_cois/constants.dart';
import 'package:uok_cois/models/post_response.dart';
import 'package:uok_cois/view/screens/posts/widgets/post_img_widget.dart';

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
        child: post.type == PostType.news
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18.0),
    );
  }

  Widget buildBottomInfo() {
    return Row(
      children: [
        Icon(
          post.type == PostType.news
              ? MdiIcons.newspaperVariant
              : MdiIcons.bullhorn,
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
                '${post.link}\nتم المشاركة من تطبيق UOK COIS يمكن تحميل التطبيق من الرابط دناة : \n $downloadAppLink ',
                subject: post.title);
          },
        ),
      ],
    );
  }

  String getPostTypeName() {
    return post.type == PostType.news ? 'اخر الاخبار' : 'الاعلانات';
  }
}
