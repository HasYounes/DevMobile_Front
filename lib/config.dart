import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const urlAuthority = '192.168.1.4:8080';
  static late int userId;
  static String jwt =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjAsImZ1bGxuYW1lIjoidGV4dCIsImVtYWlsIjoidGV4dEBrc2pmLmV4dCIsInVzZXJ0eXBlIjoiY2xpZW50IiwiaWF0IjoxNzE3MTA2NjkwLCJleHAiOjE3MjU3NDY2OTB9.oR1cvbBHwiT5Dm9Ft-CtzqAFrcoAI1G92rxq6KmT7GA';

  static Future<void> init() async {
    var sp = await SharedPreferences.getInstance();
    var token = sp.getString("jwt");
    if (sp.getString("id") != null) userId = int.parse(sp.getString("id")!);

    if (token != null) jwt = token;
  }
}
