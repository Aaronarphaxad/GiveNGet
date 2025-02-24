import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> saveCredentials(String email, String password, String userStatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('userStatus', userStatus);  // Save the user status
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email'),
      'password': prefs.getString('password'),
      'userStatus': prefs.getString('userStatus'),  // Fetch user status
    };
  }

  static Future<bool> authenticate(String email, String password) async {
    final credentials = await getCredentials();
    return credentials['email'] == email && credentials['password'] == password;
  }
}
