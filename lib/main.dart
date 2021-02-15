import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/api/user.api.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';
import 'package:selfmemory_flutter/views/memory.dart';
import 'package:selfmemory_flutter/views/navigator.dart';
import 'package:selfmemory_flutter/views/signup.dart';

import 'views/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    NavigatorPage.tag: (context) => NavigatorPage(),
    MemoryPage.tag: (context) => MemoryPage(),
    ChapterPage.tag: (context) => ChapterPage(),
    ConfigPage.tag: (context) => ConfigPage(),
    SignupPage.tag: (context) => SignupPage()
  };

  Future<Widget> _CheckInit(context) async {
    final String token = await getToken();
    if (!token.isEmpty) {
      final user = await whoAmI();
      if (user != null) {
        return NavigatorPage();
      } else {
        return LoginPage();
      }
    } else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelfMemory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Anonymous',
      ),
      home: FutureBuilder<Widget>(
          future: _CheckInit(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? snapshot.data
                : Center(
                    child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
                  ));
          }),
      //change
      routes: routes,
    );
  }
}
