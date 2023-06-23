import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class BannerService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  //Obtener banner
  Future<ApiResModel> getBanner(
    String user,
    String token,
  ) async {
    //manejo de errores
    try {
      //completar url
      Uri url = Uri.parse("${_baseUrl}Banner/$user");

      //uso de http para consumir el api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
          "user": user,
        },
      );

      //respuesta del api
      final resJson = json.decode(response.body);

      //Respuesta correcta: Lista de datos
      List<BannerModel> banner = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = BannerModel.fromMap(item);
        //agregar item a la lista
        banner.add(responseFinally);
      }

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: banner,
      );
    } catch (e) {
      //en caso de error
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
