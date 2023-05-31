import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginService extends ChangeNotifier {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  // Consume el Api
  Future<ApiResModel> postLogin(LoginModel loginModel) async {
    //  Consumo del Api
    try {
      // Arma Url del Api
      final url =
          Uri.https(_baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/Login");
      // Configurar Api y consumirla
      final response = await http.post(url,
          body: loginModel.toJson(),
          headers: {"Content-Type": "application/json"});
      // Asignar respuesta del Api ResLogin
      RespLogin respLogin = RespLogin.fromMap(jsonDecode(response.body));

      return ApiResModel(
        succes: true,
        message: respLogin,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
