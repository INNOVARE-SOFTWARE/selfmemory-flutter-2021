import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/views/memory.dart';

import 'views/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    MemoryPage.tag: (context) => MemoryPage()
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
      home: LoginPage(), //change
      routes: routes,
    );
  }
}
