//save chapter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selfmemory_flutter/models/chapter_model.dart';
import 'package:selfmemory_flutter/preferences/global.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';

Future<Chapter> createChapter(Chapter chapter) async {
  final response = await http.post(Global.url + '/chapters',
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + await getToken() //for user auth
      },
      body: jsonEncode({
        // id is auto
        'title': chapter.title,
        'text': chapter.text,
        'memoryId': chapter.memoryId
      }));
  if (response.statusCode == 200) {
    return Chapter.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}

Future<bool> updateChapter(Chapter chapter) async {
  final response = await http.patch(Global.url + '/chapters/' + chapter.id,
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + await getToken() //for user auth
      },
      body: jsonEncode({
        'id': chapter.id,
        'title': chapter.title,
        'text': chapter.text,
        'memoryId': chapter.memoryId
      }));
  if (response.statusCode == 204) {
    print('ok');
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteChapter(Chapter chapter) async {
  final response =
      await http.delete(Global.url + '/chapters/' + chapter.id, headers: {
    "Content-Type": "application/json",
    "Authorization": 'Bearer ' + await getToken() //for user auth
  });
  if (response.statusCode == 204) {
    print('ok');
    return true;
  } else {
    return false;
  }
}
