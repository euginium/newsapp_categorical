import 'package:flutter/material.dart';
import 'package:news_app_webview/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.blue,
        splashColor: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
