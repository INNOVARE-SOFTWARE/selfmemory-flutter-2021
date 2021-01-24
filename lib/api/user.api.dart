// LOGIN
import 'dart:convert';

import 'package:selfmemory_flutter/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:selfmemory_flutter/models/token_model.dart';
import 'package:selfmemory_flutter/preferences/global.dart';
import 'package:selfmemory_flutter/preferences/shared_preferences.dart';

Future<String> loginApi(LoginModel data) async {
  try {
    final response = await http.post(Global.url + '/users/login',
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toMap()));
    if (response.statusCode == 200) {
      var token = TokenModel.fromJson(json.decode(response.body));
      setToken(token.token); //add preferences
      return token.token;
    } else {
      print(response.statusCode);
      return null;
    }
  } catch (e) {
    print(e);
  }
}
