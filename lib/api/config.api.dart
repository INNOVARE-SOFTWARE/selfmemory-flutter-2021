import 'dart:convert';

import 'package:selfmemory_flutter/models/chapter_model.dart';
import 'package:selfmemory_flutter/models/config_model.dart';
import 'package:selfmemory_flutter/preferences/global.dart';
import 'package:http/http.dart' as http;
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';

//get Config created or saved
Future<Config> createOrReadConfig(String userid) async {
  final response =
  await http.get(Global.url + '/configs/' + userid, headers: {
    "Content-Type": "application/json",
    "Authorization": 'Bearer ' + await getToken() //for user auth
  });
  if (response.statusCode == 200) {
    try {
      return Config.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  } else {
    return null;
  }
}

//save Config
Future<bool> saveConfig(Config Config) async {
  final response = await http.patch(Global.url + '/configs/' + Config.id,
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + await getToken() //for user auth
      },
      body: jsonEncode({
        'id': Config.id,
        'email1': Config.email1,
        'email2': Config.email2,
        'userId':Config.userId
      }));
  if (response.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}