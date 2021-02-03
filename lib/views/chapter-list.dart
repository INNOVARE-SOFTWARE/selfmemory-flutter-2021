import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:selfmemory_flutter/models/chapter_model.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> data;

  ChapterList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data == null || data.isEmpty
        ? Center(child: Text('Sin Datos'))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Column(
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
                                size: 35,
                              ),
                              onPressed: () {
                                //navigate
                              }),
                          isThreeLine: false,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
  }
}
