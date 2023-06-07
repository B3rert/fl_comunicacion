import 'dart:convert';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class PostService {
  // Url del servidor
  final String _baseUrl = Preferences.baseUrl;
  //path
  final String _path = Preferences.path;

  Future<ApiResModel> getPosts(
    String user,
    String token,
  ) async {
    try {
      Uri url;
      if (Preferences.prefix == 'https') {
        url = Uri.https(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/$user");
      } else {
        url = Uri.http(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/$user");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<PostModel> posts = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = PostModel.fromMap(item);
        //agregar item a la lista
        posts.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: posts,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
