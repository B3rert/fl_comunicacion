import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  Future<ApiResModel> getInfoUser(
    String user,
    String token,
  ) async {
    try {
      Uri url;

      if (Preferences.prefix == 'https') {
        url = Uri.https(
            _baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/User/info/$user");
      } else {
        url = Uri.http(
            _baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/User/info/$user");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<InfoUserModel> info = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = InfoUserModel.fromMap(item);
        //agregar item a la lista
        info.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: info,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
