import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';
import 'package:selfmemory_flutter/views/memory.dart';
import 'package:selfmemory_flutter/views/navigator.dart';

import 'views/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    NavigatorPage.tag: (context) => NavigatorPage(),
    MemoryPage.tag: (context) => MemoryPage(),
    ChapterPage.tag: (context) => ChapterPage(),
    ConfigPage.tag: (context) => ConfigPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelfMemory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Roboto',
      ),
      home: LoginPage(),
      //change
      routes: routes,
    );
  }
}
