import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uok_cois/constants.dart';
import 'package:uok_cois/view/screens/posts/posts_screen.dart';

class Destination {
  final int index;
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final MaterialColor color;

  const Destination(
      {this.index, this.title, this.icon, this.activeIcon, this.color});
}

const List<Destination> allDestination = [
  Destination(
      index: 0,
      title: 'اخر الاخبار',
      icon: MdiIcons.newspaperVariantOutline,
      activeIcon: MdiIcons.newspaperVariant,
      color: Colors.green),
  Destination(
      index: 1,
      title: 'الرئيسية',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      color: Colors.green),
  Destination(
      index: 2,
      title: 'الاعلانات',
      icon: MdiIcons.bullhornOutline,
      activeIcon: MdiIcons.bullhorn,
      color: Colors.green),
];

List<Widget> allDestinationView = [
  PostsScreen(
    postType: PostType.news,
  ),
  PostsScreen(
    postType: PostType.all,
  ),
  PostsScreen(
    postType: PostType.ads,
  ),
];
