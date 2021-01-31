import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  static String tag = 'chapter-page'; //for routes

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("Chapter"));
  }
}
