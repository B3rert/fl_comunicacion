import 'package:shared_preferences/shared_preferences.dart';

/// Guardar Preferencias de usuario
/// Clave Valor con Shared Prefrences

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = "";
  static String _userName = "";
  static String _urlApi = "";

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

  static void clearToken() {
    _prefs.remove("token");
    _prefs.remove("userName");
  }

  static String get urlApi {
    return _prefs.getString("urlApi") ?? _urlApi;
  }

  static set urlApi(String urlApi) {
    _urlApi = urlApi;
    _prefs.setString("urlApi", urlApi);
  }

  static void clearUrl() {
    _prefs.remove("urlApi");
  }
}
