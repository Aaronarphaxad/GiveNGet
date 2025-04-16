import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _clientId = 'givenget';
  static const String _clientSecret = 'SuperSecret';
  // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
  static const String _tokenEndpoint = 'http://0.0.0.0:9000/oauth2/token';
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
      Uri.parse('http://0.0.0.0:8080/api/givenget/auth/signup'), // update path if different
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
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

Future<bool> loginUser({
  required String email,
  required String password,
}) async {
  final loginRequest = {
    'email': email,
    'password': password,
  };

  final response = await http.post(
    // CHANGE THE IP BELOW TO YOUR PC'S IP OR ELSE IT WON'T WORK
    Uri.parse('http://0.0.0.0:8080/api/givenget/auth/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(loginRequest),
  );

  if (response.statusCode == 200) {
    print('✅ Login success');
    return true;
  } else {
    print('❌ Login failed: ${response.statusCode}');
    return false;
  }
}

}