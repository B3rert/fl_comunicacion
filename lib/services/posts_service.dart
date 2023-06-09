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

  Future<ApiResModel> getComments(
    String user,
    String token,
    int tarea,
  ) async {
    try {
      Uri url;
      if (Preferences.prefix == 'https') {
        url = Uri.https(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/comentarios/$user/$tarea");
      } else {
        url = Uri.http(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/comentarios/$user/$tarea");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<CommentModel> comments = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = CommentModel.fromMap(item);
        //agregar item a la lista
        comments.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: comments,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }

  Future<ApiResModel> getFilesComments(
    String user,
    String token,
    int tarea,
    int comentario,
  ) async {
    try {
      Uri url;
      if (Preferences.prefix == 'https') {
        url = Uri.https(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/comentarios/archivos/$user/$tarea/$comentario");
      } else {
        url = Uri.http(_baseUrl,
            "${_path.isEmpty ? '' : _path + '/'}api/Publicacion/comentarios/archivos/$user/$tarea/$comentario");
      }

      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<FilesCommentModel> files = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = FilesCommentModel.fromMap(item);
        //agregar item a la lista
        files.add(responseFinally);
      }

      return ApiResModel(
        succes: true,
        message: files,
      );
    } catch (e) {
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
