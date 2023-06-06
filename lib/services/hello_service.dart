import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:http/http.dart' as http;

class HelloService {
  // Consume el Api
  Future<ApiResModel> getHello(
    String baseUrl,
    String path,
  ) async {
    //  Consumo del Api
    try {
      // Arma Url del Api
      final url =
          Uri.http(baseUrl, "${path.isEmpty ? '' : path + '/'}api/Hello");

      // Configurar Api y consumirla
      final response = await http.get(url);

      // Asignar respuesta del Api
      RespLogin respHello = RespLogin.fromMap(jsonDecode(response.body));

      //retornar respuesta correcta
      return ApiResModel(succes: true, message: respHello);
    } catch (e) {
      //retornar respuesta incorecta
      return ApiResModel(succes: false, message: e.toString());
    }
  }
}
