import 'package:givenget/models/user.dart';
import 'package:givenget/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> initializeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      setUserId(userId);

      // Fetch full user profile
      final user = await UserService().fetchUserById(userId);
      if (user != null) {
        setCurrentUser(user);
        print('✅ SessionManager initialized with user: ${user.email}');
      } else {
        print('⚠️ Failed to fetch user from backend');
      }
    } else {
      print('⚠️ No userId found in SharedPreferences');
    }
  }
}