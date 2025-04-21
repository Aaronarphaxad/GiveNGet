import 'package:givenget/models/donation_item.dart';
import 'package:givenget/models/user.dart';
import 'package:givenget/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {

  Future<User?> fetchUserById(String userId) async {
    // CHANGE IP HERE
    final url = Uri.parse('http://192.168.1.87:8080/api/givenget/users/$userId');

    try {
      // 🔐 Get the access token (assumes getAccessToken returns a Map)
      // AuthService authService = AuthService();
      // final token = await authService.getAccessToken();
      final prefs = await SharedPreferences.getInstance();
      // final userProfile = await AuthService().getUserProfile();
      final token = prefs.getString('token');

      print('🔐 Access Token: $token');


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

        print('✅ User JSON: ${response.body}');
        print('👤 Fetched user: ${user.name} - ${user.email} - ${user.id}');

        return user;
      } else {
        print('❌ Failed to fetch user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('🔥 Error fetching user: $e');
      return null;
    }
  }

  Future<bool> updateUserProfile(Map<String, String> updatedFields) async {
    final prefs = await SharedPreferences.getInstance();
    final userProfile = await AuthService().getUserProfile();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId');

    if (token == null || userId == null) {
      print('❌ Missing token or userId');
      return false;
    }

    final url = Uri.parse('http://192.168.1.87:8080/api/givenget/users/$userId');

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedFields),
    );

    if (response.statusCode == 200) {
      print('✅ Profile update successful');
      return true;
    } else {
      print('❌ Failed to update profile: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

}