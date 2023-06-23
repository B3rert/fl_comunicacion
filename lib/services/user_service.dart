import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  //obtener informacion del usario
  Future<ApiResModel> getInfoUser(
    String user,
    String token,
  ) async {
    //manejo de errores
    try {
      //url del api
      Uri url = Uri.parse("${_baseUrl}User/info/$user");

      //consumo y configuraciin del api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );

      //respuesta del api
      final resJson = json.decode(response.body);

      //informacion del usario
      List<InfoUserModel> info = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = InfoUserModel.fromMap(item);
        //agregar item a la lista
        info.add(responseFinally);
      }

      //Respuesta correcta
      return ApiResModel(
        succes: true,
        message: info,
      );
    } catch (e) {
      //Respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
