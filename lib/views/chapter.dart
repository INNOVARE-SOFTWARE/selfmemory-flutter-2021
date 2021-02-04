import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/api/memory.api.dart';
import 'package:selfmemory_flutter/models/chapter_model.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';
import 'package:selfmemory_flutter/views/chapter-data.dart';
import 'package:selfmemory_flutter/views/chapter-list.dart';

import 'navigator.dart';

class ChapterPage extends StatefulWidget {
  static String tag = 'chapter-page'; //for routes
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  String memoryid = '';

  @override
  initState() {
  }

  Future<List<Chapter>> loadChapters() async {
    this.memoryid = await getMemoryId();
    return await getChapters(this.memoryid);
  }

  @override
  Widget build(BuildContext context) {
    final newButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChapterDataForm(
                    chapter: new Chapter(), memoryId: this.memoryid)),
          ).then((value) {
            //callback
            setState(() {
              loadChapters();
            });
          });
          ;
        },
        child: Text('Nuevo Capítulo', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
          newButton,
          new Divider(
            color: Colors.grey,
          ),
          Padding(
            child: FutureBuilder<List<Chapter>>(
              future: loadChapters(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                //
                return snapshot.hasData
                    ? ChapterList(data: snapshot.data)
                    : Center(
                        child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.grey),
                      ));
              },
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
        ]));
  }
}
