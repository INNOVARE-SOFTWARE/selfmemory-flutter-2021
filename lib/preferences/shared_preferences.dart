import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token") ?? "";
}

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("token", value);
}

Future<String> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("userid") ?? "";
}

Future<bool> setUserId(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("userid", value);
}
