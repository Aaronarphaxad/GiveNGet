import 'package:givenget/services/session_manager.dart';
import 'package:givenget/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _clientId = 'givenget';
  static const String _clientSecret = 'SuperSecret';
  // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
  static const String _tokenEndpoint = 'http://192.168.1.126:9000/oauth2/token';
  static const List<String> _scopes = ['givenget:read', 'givenget:write'];

  Future<String?> getAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse(_tokenEndpoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'scope': _scopes.join(' '),
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> tokenData = jsonDecode(response.body);
        print("Full Token Data: $tokenData");
        return tokenData['access_token'];
      } else {
        print('❌ Failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ Exception: $e');
      return null;
    }
  }


  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    String location = 'unknown',
  }) async {
    // Get the access token
    print('Registering user...');

    final token = await getAccessToken();
    print("My Token: $token");
    if (token == null) {
      print('❌ Cannot register user without token');
      return;
    }

    final signupRequest = {
      'name': name,
      'email': email,
      'phoneNum': phone,
      'password': password,
      'location': location,
    };

    final response = await http.post(
      // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
      Uri.parse('http://192.168.1.126:8080/api/givenget/auth/signup'), // update path if different
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(signupRequest),
    );

    if (response.statusCode == 200) {
      print("✅ User registered successfully: ${response.body}");
    } else if (response.statusCode == 400) {
      print('⚠️ Email already exists: ${response.body}');
    } else {
      print(response.statusCode);
      print('❌ Registration failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    final loginRequest = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.126:8080/api/givenget/auth/login'),
      headers: {
        // 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginRequest),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Login Response: $data');

      final userId = data['userId'];
      final token = data['accessToken'];

      if (userId == null || token == null) {
        print('❌ userId or token is null. Response: $data');
        return null;
      }

      // ✅ Save token & userId BEFORE doing anything else
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('userId', userId);

      // Save in session if needed
      SessionManager().setUserId(userId);

      // ✅ Now fetch user (this will succeed now that token is saved)
      final user = await UserService().fetchUserById(userId);
      if (user != null) SessionManager().setCurrentUser(user);

      return {
        'userId': userId,
        'token': token,
      };
    }

    return null;
  }


  Future<Map<String, dynamic>?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    // final token = await getAccessToken();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId');

    print('🔐 token: $token');
    print('👤 userId: $userId');

    if (token == null || userId == null) return null;


    final url = 'http://192.168.1.126:8080/api/givenget/users/$userId';
    print('🌐 GET $url');
    // IP ADDRESS
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('📡 Response code: ${response.statusCode}');
    print('📡 Response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('❌ Failed to fetch profile: ${response.statusCode}');
      return null;
    }
  }


}