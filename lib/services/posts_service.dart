import 'dart:convert';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class PostService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  Future<ApiResModel> getPosts(
    String user,
    String token,
  ) async {
    try {
      Uri url = Uri.parse("${_baseUrl}Publicacion/$user");

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
      Uri url = Uri.parse("${_baseUrl}Publicacion/comentarios/$user/$tarea");

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
      Uri url = Uri.parse(
          "${_baseUrl}Publicacion/comentarios/archivos/$user/$tarea/$comentario");

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

  // Consume el Api
  Future<ApiResModel> postPost(
    String token,
    PostPostModel post,
  ) async {
    //  Consumo del Api
    try {
      Uri url = Uri.parse("${_baseUrl}Publicacion");

      // Configurar Api y consumirla
      final response = await http.post(
        url,
        body: post.toJson(),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "bearer $token",
        },
      );
      final resJson = json.decode(response.body);

      List<PostResModel> posts = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = PostResModel.fromMap(item);
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

  // Consume el Api
  Future<ApiResModel> posComment(
    String token,
    PostCommentModel comment,
  ) async {
    //  Consumo del Api
    try {
      Uri url = Uri.parse("${_baseUrl}Publicacion/comentario");

      // Configurar Api y consumirla
      final response = await http.post(
        url,
        body: comment.toJson(),
        headers: {
          "Content-Type": "application/json",
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
}
