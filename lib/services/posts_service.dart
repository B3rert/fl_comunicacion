import 'dart:convert';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:http/http.dart' as http;

class PostService {
  // Url del servidor
  final String _baseUrl = Preferences.urlApi;

  //obtener publicaciones
  Future<ApiResModel> getPosts(
    String user,
    String token,
  ) async {
    //manejo de errores
    try {
      //url del servidor
      Uri url = Uri.parse("${_baseUrl}Publicacion/$user");

      //consumo y configuracion del api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );

      //Respuesta del apo
      final resJson = json.decode(response.body);

      //Guardar publicaciones
      List<PostModel> posts = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = PostModel.fromMap(item);
        //agregar item a la lista
        posts.add(responseFinally);
      }

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: posts,
      );
    } catch (e) {
      //Respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }

  //obtener comentarios
  Future<ApiResModel> getComments(
    String user,
    String token,
    int tarea,
  ) async {
    try {
      //url del api
      Uri url = Uri.parse("${_baseUrl}Publicacion/comentarios/$user/$tarea");

      //consumo y configuracion del api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );

      //Respuesta del api
      final resJson = json.decode(response.body);

      //guardar comentarios
      List<CommentModel> comments = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = CommentModel.fromMap(item);
        //agregar item a la lista
        comments.add(responseFinally);
      }

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: comments,
      );
    } catch (e) {
      //respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }

  //obtener archivos de comentario
  Future<ApiResModel> getFilesComments(
    String user,
    String token,
    int tarea,
    int comentario,
  ) async {
    try {
      //url del api
      Uri url = Uri.parse(
          "${_baseUrl}Publicacion/comentarios/archivos/$user/$tarea/$comentario");

      //consumo y configuracion del api
      final response = await http.get(
        url,
        headers: {
          "Authorization": "bearer $token",
        },
      );
      //respuesta del api
      final resJson = json.decode(response.body);

      //Guatradar archivos encontrados
      List<FilesCommentModel> files = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = FilesCommentModel.fromMap(item);
        //agregar item a la lista
        files.add(responseFinally);
      }

      //Respuesta correcta
      return ApiResModel(
        succes: true,
        message: files,
      );
    } catch (e) {
      //respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }

  //Crear nueva publicacion
  Future<ApiResModel> postPost(
    String token,
    PostPostModel post,
  ) async {
    //manejo de erroes
    try {
      //url del api
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

      //Respuesta del api
      final resJson = json.decode(response.body);

      //Guardar respues del servicio
      List<PostResModel> posts = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = PostResModel.fromMap(item);
        //agregar item a la lista
        posts.add(responseFinally);
      }

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: posts,
      );
    } catch (e) {
      //Respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }

  //Crear nuevo comentario
  Future<ApiResModel> posComment(
    String token,
    PostCommentModel comment,
  ) async {
    //url del api
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

      //Respuesta del api
      final resJson = json.decode(response.body);

      //Comentario creado devulto por el PA
      List<CommentModel> comments = [];

      //recorrer lista api Y  agregar a lista local
      for (var item in resJson) {
        //Tipar a map
        final responseFinally = CommentModel.fromMap(item);
        //agregar item a la lista
        comments.add(responseFinally);
      }

      //respuesta correcta
      return ApiResModel(
        succes: true,
        message: comments,
      );
    } catch (e) {
      //respuesta incorrecta
      return ApiResModel(
        succes: false,
        message: e.toString(),
      );
    }
  }
}
