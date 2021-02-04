import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';
import 'package:selfmemory_flutter/views/login.dart';
import 'package:selfmemory_flutter/views/memory.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'app_bar');

class NavigatorPage extends StatefulWidget {
  static String tag = 'nav-page'; //for routes

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  static int index = 0;

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return MemoryPage();
      case 1:
        return ChapterPage();
      case 2:
        return ConfigPage();
    }
  }

  Future<bool> _onWillPop() {
    //async
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Estás seguro?'),
            content: new Text('Quieres abandonar SelfMemory?'),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () async {
                  await setToken(null);
                  await setMemoryId(null);
                  await setUserId(null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );                },
                child: new Text('Si'),
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[600],
            automaticallyImplyLeading: false,
            title: Text("Self Memory"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    _onWillPop(); //logout
                  }),
            ],
          ),
          body: _getBody(index),
          bottomNavigationBar: BottomNavigationBar(
            key: globalKey,
            // KEY!!
            type: BottomNavigationBarType.fixed,
            onTap: (value) => setState(() => index = value),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note_outlined),
                label: "Memory",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: "Chapter",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_outlined),
                label: "Config",
              ),
            ],
            currentIndex: index,
            selectedItemColor: Colors.grey[800],
          ),
        ));
  }
}
