import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Key for storing users in SharedPreferences
  static const String _usersKey = 'users';

  static Future<void> saveUserDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String userStatus,
  })

  async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_usersKey) ?? [];

    final user = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'userStatus': userStatus,
    };

    final userJson = user.entries.map((e) => '${e.key}:${e.value}').join(',');

    users.add(userJson);

    await prefs.setStringList(_usersKey, users);
  }

  static Future<Map<String, String>?> getUserByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_usersKey) ?? [];

    for (final userJson in users) {
      final user = userJson.split(',').map((e) {
        final parts = e.split(':');
        return MapEntry(parts[0], parts[1]);
      }).toList().fold<Map<String, String>>({}, (map, entry) {
        map[entry.key] = entry.value;
        return map;
      });

      if (user['email'] == email) {
        return user;
      }
    }

    return null;
  }

  static Future<bool> authenticate(String email, String password) async {
    final user = await getUserByEmail(email);
    return user != null && user['password'] == password;
  }
}