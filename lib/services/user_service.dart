import 'package:givenget/models/donation_item.dart';
import 'package:givenget/models/user.dart';
import 'package:givenget/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {

Future<User?> fetchUserById(String userId) async {
  final url = Uri.parse('http://192.168.1.87:8080/api/givenget/users/$userId');

  try {
    // 🔐 Get the access token (assumes getAccessToken returns a Map)
    AuthService authService = AuthService();
    final token = await authService.getAccessToken();
    print('🔐 Access Token: $token');
   

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final user = User.fromJson(json);

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




}