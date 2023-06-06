import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class WelcomeService {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  Future<ApiResModel> getWelcome(
    String user,
    String token,
  ) async {
    try {
      Uri url;
      if (Preferences.prefix == 'https') {
        url = Uri.https(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Bienvenida/$user");
      } else {
        url = Uri.http(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Bienvenida/$user");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<WelcomeModel> bienvenidas = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //JSON a map
        Map<String, dynamic> mensaje = item;
        //Tipar a map
        final responseFinally = WelcomeModel.fromMap(mensaje);
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
