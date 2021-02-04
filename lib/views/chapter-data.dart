import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfmemory_flutter/api/chapter.api.dart';
import 'package:selfmemory_flutter/models/chapter_model.dart';

import 'navigator.dart';

class ChapterDataForm extends StatefulWidget {
  static String tag = 'chapter-data-form'; //for routes
  var chapter = new Chapter();
  var memoryId = '';

  ChapterDataForm({Key key, this.chapter, this.memoryId})
      : super(key: key); //constructor

  @override
  _ChapterDataForm createState() => _ChapterDataForm();
}

class _ChapterDataForm extends State<ChapterDataForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();
  var _showCircularProgressIndicator = false;
  BottomNavigationBar navigationBar;

  @override
  initState() {
    navigationBar = globalKey.currentWidget;
    //for edit
    this.titleController.text =
        this.widget.chapter != null ? this.widget.chapter.title : '';
    this.textController.text =
        this.widget.chapter != null ? this.widget.chapter.text : '';
    if (this.widget.chapter == null) this.widget.chapter = new Chapter();
  }

  Future<void> saveChapter() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    this.widget.chapter.text = this.textController.text;
    this.widget.chapter.title = this.titleController.text;
    this.widget.chapter.memoryId = this.widget.memoryId; //

    print(this.widget.chapter.memoryId);
    var result;

    if (this.widget.chapter.id != null) {
      result = await updateChapter(this.widget.chapter);
    } else {
      result = await createChapter(this.widget.chapter);
    }
    if (result != null) {
      setState(() {
        //important!
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Datos almacenados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Imposible guardar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkIfDelete() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Estás seguro?'),
            content: new Text('Quieres eliminar el Capítulo?'),
            actions: <Widget>[
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);  //for popup
                },
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); //for popup
                  //
                  this.removeChapter();
                  navigationBar.onTap(1); //reload
                  Navigator.pop(context); //POP for this class
                },
                child: new Text('Si'),
              )
            ],
          ),
        ) ??
        false;
  }

  Future<void> removeChapter() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    var result;
    if (this.widget.chapter.id != null) {
      result = await deleteChapter(this.widget.chapter);
    }
    if (result != null) {
      setState(() {
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Datos eliminados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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

    final text = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLines: 8,
      controller: textController,
      decoration: InputDecoration(
        hintText: 'Mis letras aquí',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          this.saveChapter();
          Navigator.pop(context);
          navigationBar.onTap(1); //other widget in tree
        },
        child: Text('Guardar', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[400], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          Navigator.pop(context); //POP
          navigationBar.onTap(1);
        },
        child: Text('Volver', style: TextStyle(color: Colors.white)),
      ),
    );

    final removeButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Visibility(
          visible: this.widget.chapter.id != null,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red[400], // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              checkIfDelete();
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.white)),
          )),
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
            removeButton,
            backButton
          ],
        ),
      ),
    );
  }
}
