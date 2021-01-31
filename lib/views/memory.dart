import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';

class MemoryPage extends StatefulWidget {
  static String tag = 'memory-page'; //for routes

  @override
  _MemoryPageState createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

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

    final subtitle = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: subtitleController,
      decoration: InputDecoration(
        hintText: 'SubTítulo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          //save here
        },
        child: Text('Guardar', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text("Actualiza tu libro",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueGrey)),
            SizedBox(height: 18.0),
            title,
            SizedBox(height: 8.0),
            subtitle,
            SizedBox(height: 24.0),
            saveButton
          ],
        ),
      ),
    );
  }
}
