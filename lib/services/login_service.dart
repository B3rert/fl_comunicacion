import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class LoginService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  //Login de usuario
  Future<ApiResModel> postLogin(LoginModel loginModel) async {
    //manejo de errores
    try {
      //url completa
      Uri url = Uri.parse("${_baseUrl}Login");

      // Configurar Api y consumirla
      final response = await http.post(
        url,
        body: loginModel.toJson(),
        headers: {"Content-Type": "application/json"},
      );
      // Asignar respuesta del Api ResLogin
      RespLogin respLogin = RespLogin.fromMap(jsonDecode(response.body));

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: respLogin,
      );
    } catch (e) {
      //respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
