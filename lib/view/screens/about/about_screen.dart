import 'package:flutter/material.dart';
import 'package:uok_cois/constants.dart';
import 'package:uok_cois/view/widgets/my_app_icon.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            MyAppIcon(size: 80),
            SizedBox(height: 16),
            Text(
              'UOK COIS',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(appVersion),
            Spacer(),
            FlatButton(
              child: Text('عرض الترخيص'),
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationIcon: MyAppIcon(),
                  applicationVersion: appVersion,
                );
              },
            ),
            Spacer(
              flex: 8,
            ),
            Text(
              'تطوير محمود علي',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black),
            ),
            Text(
              'وحدة الموقع الاكتروني',
              style: Theme.of(context).textTheme.caption,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
