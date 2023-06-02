import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BannerService extends ChangeNotifier {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  Future<ApiResModel> getBanner(
    String user,
    String token,
  ) async {
    try {
      final url = Uri.http(
          _baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/Banner/$user");
      final response = await http.get(
        url,
        headers: {"Authorization": "bearer $token", "user": user},
      );
      final resJson = json.decode(response.body);

      List<BannerModel> banner = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //JSON a map
        Map<String, dynamic> application = item;
        //Tipar a map
        final responseFinally = BannerModel.fromMap(application);
        //agregar item a la lista
        banner.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: banner,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
