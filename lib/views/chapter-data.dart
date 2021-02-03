import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfmemory_flutter/api/memory.api.dart';
import 'package:selfmemory_flutter/models/chapter_model.dart';
import 'package:selfmemory_flutter/models/memory_model.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';

class ChapterDataForm extends StatefulWidget {
  static String tag = 'chapter-data-form'; //for routes

  @override
  _ChapterDataForm createState() => _ChapterDataForm();
}

class _ChapterDataForm extends State<ChapterDataForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  var _showCircularProgressIndicator = false;
  var chapter = new Chapter();

  @override
  initState() {}

  @override
  Widget build(BuildContext context) {
    final title = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: titleController,
      decoration: InputDecoration(
        hintText: 'Título',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final text = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLines: 8,
      controller: titleController,
      decoration: InputDecoration(
        hintText: 'Mis letras aquí',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {},
        child: Text('Guardar', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[400], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Volver', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _showCircularProgressIndicator
                    ? CircularProgressIndicator()
                    : Container(),
              ],
            ),
            Text("Escribe tus memorias",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueGrey)),
            SizedBox(height: 18.0),
            title,
            SizedBox(height: 8.0),
            text,
            SizedBox(height: 24.0),
            saveButton,
            backButton
          ],
        ),
      ),
    );
  }
}
