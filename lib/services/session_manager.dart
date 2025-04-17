import 'package:givenget/models/user.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  String? _userId;
  User? _currentUser;

  // Set and get user ID
  void setUserId(String userId) {
    _userId = userId;
  }

  String? getUserId() {
    return _userId;
  }

  // Set and get current User
  void setCurrentUser(User user) {
    _currentUser = user;
  }

  User? getCurrentUser() {
    return _currentUser;
  }

  // Optional: clear session
  void clear() {
    _userId = null;
    _currentUser = null;
  }
}