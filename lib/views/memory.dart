import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfmemory_flutter/api/memory.api.dart';
import 'package:selfmemory_flutter/models/memory_model.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';
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
  var _showCircularProgressIndicator = false;

  @override
  initState() {
    loadMyMemory(); //call init state
  }

  Future<Memory> loadMyMemory() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    Memory memory = await createOrReadMemory(await getUserId());
    if (memory != null) {
      await setMemoryId(memory.id);
      setState(() { //important!
        _showCircularProgressIndicator = false;
        //fill data
        this.titleController.text = memory.title;
        this.subtitleController.text = memory.subtitle;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Imposible obtener datos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

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
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          //save here
        },
        child: Text('Guardar',
            style: TextStyle(color: Colors.white)),
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
            saveButton,

          ],
        ),
      ),
    );
  }
}
