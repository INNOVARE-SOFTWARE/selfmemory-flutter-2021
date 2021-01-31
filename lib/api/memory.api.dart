import 'dart:convert';

import 'package:selfmemory_flutter/models/chapter_model.dart';
import 'package:selfmemory_flutter/models/memory_model.dart';
import 'package:selfmemory_flutter/preferences/global.dart';
import 'package:http/http.dart' as http;
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';

//get memory created or saved
Future<Memory> createOrReadMemory(String userid) async {
  final response =
      await http.get(Global.url + 'memories/user/' + userid, headers: {
    "Content-Type": "application/json",
    "Authorization": await getToken() //for user auth
  });
  if (response.statusCode == 200) {
    try {
      return Memory.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

//get all chapters from user memory
Future<List<Chapter>> getChapters(String memoryId) async {
  final response = await http
      .get(Global.url + 'memories/' + memoryId + '/chapters', headers: {
    "Content-Type": "application/json",
    "Authorization": await getToken() //for user auth
  });
  if (response.statusCode == 200) {
    try {
      var responseJson = json.decode(response.body);
      var data =
          (responseJson as List).map((p) => Chapter.fromJson(p)).toList();
      return data;
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}
