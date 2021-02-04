import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/models/chapter_model.dart';

import 'chapter-data.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> data;

  ChapterList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data == null || data.isEmpty
        ? Center(child: Text('Sin Datos'))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                          title: new Text(
                            (index + 1).toString() + ' - ' + data[index].title,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                fontSize: 19.0),
                          ),
                          trailing: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterDataForm(
                                          chapter: data[index],
                                          memoryId: data[index].memoryId)),
                                ).then((value) {});
                              }),
                          isThreeLine: false),
                    ],
                  ),
                ],
              );
            },
          );
  }
}
