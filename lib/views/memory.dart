import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/views/chapter.dart';
import 'package:selfmemory_flutter/views/config.dart';

class MemoryPage extends StatefulWidget {
  static String tag = 'memory-page'; //for routes

  @override
  _MemoryPageState createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Config"));
  }
}
