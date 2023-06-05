import 'dart:convert';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PublicacionService extends ChangeNotifier {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  // Consume el Api
  Future<ApiResModel> postLogin(
      String token, PublicacionPostModel publicacion) async {
    //  Consumo del Api
    try {
      // Arma Url del Api
      final url = Uri.https(
          _baseUrl, "${_path.isEmpty ? '' : _path + '/'}api/Publicacion");
      // Configurar Api y consumirla
      final response = await http.post(
        url,
        body: publicacion.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token",
        },
      );

      final resJson = json.decode(response.body);

      List<PublicacionGetModel> publicaciones = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //JSON a map
        Map<String, dynamic> application = item;
        //Tipar a map
        final responseFinally = PublicacionGetModel.fromMap(application);
        //agregar item a la lista
        publicaciones.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: publicaciones,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
