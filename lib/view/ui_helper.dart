import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class Helper {
  static Future<void> launchBrowser(BuildContext context, String url) async {
    try {
      await launch(url,
          option: CustomTabsOption(
              toolbarColor: Colors.white,
              enableDefaultShare: true,
              enableUrlBarHiding: true,
              showPageTitle: true));
    } catch (e) {
      debugPrint(e);
    }
  }
}
