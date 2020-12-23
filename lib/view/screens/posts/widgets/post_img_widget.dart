import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../constants.dart';

class PostImage extends StatelessWidget {
  static const _kNewsImgHeight = 230.0;
  static const _kNewsImgWidth = double.infinity;
  static const _kAdsImgHeight = 100.0;
  static const _kAdsImgWidth = 100.0;

  final PostType postType;
  final String url;

  const PostImage({Key key, this.postType, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: postType == PostType.news ? _kNewsImgHeight : _kAdsImgHeight,
      width: postType == PostType.news ? _kNewsImgWidth : _kAdsImgWidth,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox.expand(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                  image: url),
            ),
          ],
        ),
      ),
    );
  }
}
