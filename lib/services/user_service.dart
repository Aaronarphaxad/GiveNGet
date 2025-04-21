import 'dart:convert';

import 'package:givenget/models/user.dart';
import 'package:givenget/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> fetchUserById(String userId) async {
    // CHANGE IP HERE
    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/users/$userId');

    try {
      // 🔐 Get the access token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final Map<String, dynamic> json = jsonDecode(response.body);
      final user = User.fromJson(json);

      if (response.statusCode == 200) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUserProfile(Map<String, String> updatedFields) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId');

    if (token == null || userId == null) {
      return false;
    }

    final url = Uri.parse('http://192.168.1.126:8080/api/givenget/users/$userId');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedFields),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
