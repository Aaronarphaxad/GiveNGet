// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class AuthService {
//   static const String _clientId = 'givenget';
//   static const String _clientSecret = 'SuperSecret';
//   // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
//   static const String _tokenEndpoint = 'http://192.168.56.1:9000/oauth2/token';
//   static const List<String> _scopes = ['givenget:read', 'givenget:write'];
//
//   Future<String?> getAccessToken() async {
//     try {
//       final response = await http.post(
//         Uri.parse(_tokenEndpoint),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'grant_type': 'client_credentials',
//           'client_id': _clientId,
//           'client_secret': _clientSecret,
//           'scope': _scopes.join(' '),
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> tokenData = jsonDecode(response.body);
//         print("Full Token Data: $tokenData");
//         return tokenData['access_token'];
//       } else {
//         print('❌ Failed: ${response.statusCode} - ${response.body}');
//         return null;
//       }
//     } catch (e) {
//       print('❌ Exception: $e');
//       return null;
//     }
//   }
//
//
//   Future<void> registerUser({
//     required String name,
//     required String email,
//     required String phone,
//     required String password,
//     String location = 'unknown',
//   }) async {
//     // Get the access token
//     print('Registering user...');
//
//     final token = await getAccessToken();
//     print("My Token: $token");
//     if (token == null) {
//       print('❌ Cannot register user without token');
//       return;
//     }
//
//     final signupRequest = {
//       'name': name,
//       'username': email,
//       'phoneNum': phone,
//       'password': password,
//       'location': location,
//     };
//
//     final response = await http.post(
//       // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
//       Uri.parse('http://192.168.56.1:9000/api/auth/signup'), // update path if different
//       headers: {
//         'Content-Type': 'application/json',
//         // 'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(signupRequest),
//     );
//
//     if (response.statusCode == 200) {
//       print("✅ User registered successfully: ${response.body}");
//     } else if (response.statusCode == 400) {
//       print('⚠️ Email already exists: ${response.body}');
//     } else {
//       print(response.statusCode);
//       print('❌ Registration failed: ${response.statusCode} - ${response.body}');
//     }
//   }
//
// Future<bool> loginUser({
//   required String email,
//   required String password,
// }) async {
//   final loginRequest = {
//     'username': email,
//     'password': password,
//   };
//
//   final response = await http.post(
//     // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
//     Uri.parse('http://192.168.56.1:9000/api/auth/login'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(loginRequest),
//   );
//
//   if (response.statusCode == 200) {
//     print('✅ Login success');
//     return true;
//   } else {
//     print('❌ Login failed: ${response.statusCode}');
//     return false;
//   }
// }
//
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class AuthService {
  static const String _baseUrl = 'http://10.0.2.2:9000'; // CHANGE TO YOUR LOCAL IP
  static const String _signupEndpoint = '$_baseUrl/api/auth/signup';
  static const String _loginEndpoint = '$_baseUrl/api/auth/login';
  static const String _profileEndpoint = '$_baseUrl/api/auth/profile';

  /// Register a new user
  Future<void> registerUser({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final signupRequest = {
      'username': username,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };

    final response = await http.post(
      Uri.parse(_signupEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(signupRequest),
    );

    if (response.statusCode == 200) {
      print("✅ User registered: ${response.body}");
    } else if (response.statusCode == 409) {
      print("⚠️ Username already exists: ${response.body}");
    } else {
      print("❌ Failed: ${response.statusCode} - ${response.body}");
    }
  }

  /// Log in and store the JWT
  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    final loginRequest = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(_loginEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginRequest),
    );

    if (response.statusCode == 200) {
      final token = response.body.toString().replaceAll('"', '').replaceAll('Bearer ', '');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('✅ Login success: $token');
      return true;
    } else {
      print('❌ Login failed: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  /// Get user profile using the stored JWT
  Future<void> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('❌ No token found');
      return;
    }

    final response = await http.get(
      Uri.parse(_profileEndpoint),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('👤 Profile: ${response.body}');
    } else {
      print('❌ Profile fetch failed: ${response.statusCode} - ${response.body}');
    }
  }

  /// Log out (clears token)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('🔓 Logged out');
  }
}
