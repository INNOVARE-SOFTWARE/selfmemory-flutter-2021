import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selfmemory_flutter/api/config.api.dart';
import 'package:selfmemory_flutter/api/memory.api.dart';
import 'package:selfmemory_flutter/models/config_model.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  static String tag = 'config-page'; //for routes

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController email1Controller = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  var _showCircularProgressIndicator = false;
  var config = new Config();

  @override
  initState() {
    loadMyConfig(); //call init state
  }

  Future<Config> sendMyBook() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    var send = await sendBook(await getUserId());
    if (send != null) {
      setState(() {
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Mis Memorias enviadas",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Imposible enviar datos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }
  }

  Future<Config> loadMyConfig() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    this.config = await createOrReadConfig(await getUserId());
    if (this.config != null) {
      setState(() {
        //important!
        _showCircularProgressIndicator = false;
        //fill data
        this.email1Controller.text = this.config.email1;
        this.email2Controller.text = this.config.email2;
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

  Future<Config> saveMyConfig() async {
    setState(() {
      _showCircularProgressIndicator = true;
    });
    this.config.email1 = this.email1Controller.text;
    this.config.email2 = this.email2Controller.text;

    var result = await saveConfig(this.config);
    if (result) {
      setState(() {
        //important!
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Datos almacenados",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        _showCircularProgressIndicator = false;
      });
      Fluttertoast.showToast(
          msg: "Imposible editar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final email1 = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: email1Controller,
      decoration: InputDecoration(
        hintText: 'Email 1',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );

    final email2 = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: email2Controller,
      decoration: InputDecoration(
        hintText: 'Email 2',
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
          this.saveMyConfig();
        },
        child: Text('Guardar', style: TextStyle(color: Colors.white)),
      ),
    );

    final shareButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green[700], // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () {
          this.sendMyBook();
        },
        child: Text('Enviar Email', style: TextStyle(color: Colors.white)),
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
            Text("Configura los emails",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueGrey)),
            SizedBox(height: 18.0),
            email1,
            SizedBox(height: 8.0),
            email2,
            SizedBox(height: 24.0),
            saveButton,
            shareButton
          ],
        ),
      ),
    );
  }
}
