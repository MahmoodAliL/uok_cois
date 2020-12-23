import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'file:///G:/Programming/Flutter/Projects/uok_cois/lib/view/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return MaterialApp(
      title: 'UOK COIS',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', ''),
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            elevation: 1,
            color: Colors.white,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black, opacity: 0.54)),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
