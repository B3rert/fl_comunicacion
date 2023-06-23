import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class WelcomeService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  //obtener mensaje de bienvenida
  Future<ApiResModel> getWelcome(
    String user,
    String token,
  ) async {
    //manejo de errores
    try {
      //url del api
      Uri url = Uri.parse("${_baseUrl}Bienvenida/$user");

      //configuracion y consumo del api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );

      //respuesta del api
      final resJson = json.decode(response.body);

      //respuetsa lista de datos
      List<WelcomeModel> bienvenidas = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = WelcomeModel.fromMap(item);
        //agregar item a la lista
        bienvenidas.add(responseFinally);
      }

      //Respuesta correcta
      return ApiResModel(
        succes: true,
        message: bienvenidas,
      );
    } catch (e) {
      // Respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
