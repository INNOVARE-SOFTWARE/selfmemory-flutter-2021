import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  static String tag = 'config-page'; //for routes

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("Config"));
  }
}
