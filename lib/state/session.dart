import 'package:shared_preferences/shared_preferences.dart';

class Session {

  final SharedPreferences prefs;

  Session(this.prefs);

  static Future<Session> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return Session(prefs);
  }

  String? get accessToken => prefs.getString("access_token");

  void login(String token) {
    prefs.setString("access_token", token);
  }

  void logout() {
    prefs.remove("access_token");
  }
}