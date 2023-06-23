import 'package:shared_preferences/shared_preferences.dart';

/// Guardar Preferencias de usuario
/// Clave Valor con Shared Prefrences

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = ""; //token del usuario
  static String _userName = ""; //Nombre del usuario
  static String _urlApi = ""; //url de los revicios que se vayan a usar

  //iniciar shared preferences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //token
  static String get token {
    return _prefs.getString("token") ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString("token", token);
  }
  //fin token

  //nombre de usuario
  static String get userName {
    return _prefs.getString("userName") ?? _userName;
  }

  static set userName(String userName) {
    _userName = userName;
    _prefs.setString("userName", userName);
  }
  //fin nommbre de usuario

  //url de los servicios
  static String get urlApi {
    return _prefs.getString("urlApi") ?? _urlApi;
  }

  static set urlApi(String urlApi) {
    _urlApi = urlApi;
    _prefs.setString("urlApi", urlApi);
  }
  //fin url de los servicios

  //limpiar token y nombre de usuario
  static void clearToken() {
    _prefs.remove("token");
    _prefs.remove("userName");
  }

  //limpiar url de los servicios
  static void clearUrl() {
    _prefs.remove("urlApi");
  }
}
