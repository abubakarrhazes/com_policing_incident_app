import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences _sharedPreferences;
  static Preferences? _instance;

  Preferences._(); // Makes default constructor private

  static Future<Preferences> getInstance() async {
    if (_instance == null) {
      _instance = Preferences._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString('accessToken');
  }

  Future<bool> setAccessToken(String value) {
    return _sharedPreferences.setString("accessToken", value);
  }

  Future<String?> getUserId() async {
    return _sharedPreferences.getString('userId');
  }

  Future<bool> setUserId(String id) {
    return _sharedPreferences.setString("userId", id);
  }
}
