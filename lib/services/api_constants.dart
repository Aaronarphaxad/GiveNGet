class ApiConstants {
  // Replace with your machine's IP if testing on a real device
  static const String baseUrl = 'http://192.168.56.1:9000/api/auth';

  // Auth endpoints
  static const String register = '$baseUrl/signup';
  static const String login = '$baseUrl/login';
  static const String profile = '$baseUrl/profile';

  // Token (OAuth2) endpoint – adjust port if needed
  static const String tokenUrl = 'http://192.168.56.1:9000/oauth2/token';

  // OAuth2 client credentials
  static const String clientId = 'givenget';
  static const String clientSecret = 'SuperSecret';

  // Scopes
  static const List<String> scopes = ['givenget:read', 'givenget:write'];
}
