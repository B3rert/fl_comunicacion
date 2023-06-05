import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

//TODO:probar y cambniar a metodos estaticos

class BienvenidaService extends ChangeNotifier {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  Future<ApiResModel> getApplication(
    String user,
    String token,
  ) async {
    try {
      final url = Uri.http(
          _baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/Bienvenida/$user");
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<BienvenidaModel> bienvenidas = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //JSON a map
        Map<String, dynamic> mensaje = item;
        //Tipar a map
        final responseFinally = BienvenidaModel.fromMap(mensaje);
        //agregar item a la lista
        bienvenidas.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: bienvenidas,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
