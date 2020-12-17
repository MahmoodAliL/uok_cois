import 'package:flutter/material.dart';
import 'package:uok_cois/view/screens/about_screen.dart';

import 'my_app_icon.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: MyAppIcon(),
                  ),
                ),
                Text(
                  'كلية العلوم الاسلامية',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text('جامعة كربلاء'),
              ],
            ),
          ),
          ListTile(
            title: Text('حول'),
            leading: Icon(Icons.info),
            onTap: () {
              _closeDrawer(context);
              _openAboutScreen(context);
            },
          )
        ],
      ),
    );
  }

  void _openAboutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutScreen(),
      ),
    );
  }

  void _closeDrawer(BuildContext context) {
    Navigator.pop(context);
  }
}
