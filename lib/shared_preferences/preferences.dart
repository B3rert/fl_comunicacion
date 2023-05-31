import 'package:shared_preferences/shared_preferences.dart';

/// Guardar Preferencias de usuario
/// Clave Valor con Shared Prefrences

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = "";
  static String _userName = "";
  static String _baseUrl = "";
  static String _path = "";
  static String _prefix = "";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get token {
    return _prefs.getString("token") ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString("token", token);
  }

  static String get userName {
    return _prefs.getString("userName") ?? _userName;
  }

  static set userName(String userName) {
    _userName = userName;
    _prefs.setString("userName", userName);
  }

  static String get baseUrl {
    return _prefs.getString("baseUrl") ?? _baseUrl;
  }

  static set baseUrl(String baseUrl) {
    _baseUrl = baseUrl;
    _prefs.setString("baseUrl", baseUrl);
  }

  static String get path {
    return _prefs.getString("path") ?? _path;
  }

  static set path(String path) {
    _path = path;
    _prefs.setString("path", path);
  }

  static String get prefix {
    return _prefs.getString("prefix") ?? _prefix;
  }

  static set prefix(String prefix) {
    _prefix = prefix;
    _prefs.setString("prefix", prefix);
  }

  static void clearToken() {
    _prefs.remove("token");
    _prefs.remove("userName");
  }

  static void clearUrl() {
    _prefs.remove("prefix");
    _prefs.remove("path");
    _prefs.remove("baseUrl");
  }
}
