import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';
import 'package:http/http.dart' as http;

class HelloService {
  //Api de prueba para verificr servicios
  Future<ApiResModel> getHello(
    String baseUrl,
  ) async {
    //Manejo de erroes
    try {
      //url del servidor
      Uri url = Uri.parse("${baseUrl}Hello");

      // Configurar Api y consumirla
      final response = await http.get(url);

      // Asignar respuesta del Api
      RespLogin respHello = RespLogin.fromMap(jsonDecode(response.body));

      //retornar respuesta correcta
      return ApiResModel(
        succes: true,
        message: respHello,
      );
    } catch (e) {
      //retornar respuesta incorecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
