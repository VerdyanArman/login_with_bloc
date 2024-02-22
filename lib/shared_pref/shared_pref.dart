import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<void> saveUser(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('email', email);
  }

  static Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (await getUser() != null) {
      preferences.remove('email');
    }
  }

  static Future<String?> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString('email');
  }
}
