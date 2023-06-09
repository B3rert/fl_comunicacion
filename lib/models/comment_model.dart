// To parse this JSON data, do
//
//     final commentModel = commentModelFromMap(jsonString);

import 'dart:convert';

import 'package:fl_comunicacion/models/models.dart';

class CommentModel {
  int tareaComentario;
  int tarea;
  String fechaHora;
  String userName;
  String comentario;
  int estado;
  dynamic imagen;

  CommentModel({
    required this.tareaComentario,
    required this.tarea,
    required this.fechaHora,
    required this.userName,
    required this.comentario,
    required this.estado,
    required this.imagen,
  });

  factory CommentModel.fromJson(String str) =>
      CommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentModel.fromMap(Map<String, dynamic> json) => CommentModel(
        tareaComentario: json["tarea_Comentario"],
        tarea: json["tarea"],
        fechaHora: json["fecha_Hora"],
        userName: json["userName"],
        comentario: json["comentario"],
        estado: json["estado"],
        imagen: json["imagen"].toString() == "{}" ? null : json["imagen"],
      );

  Map<String, dynamic> toMap() => {
        "tarea_Comentario": tareaComentario,
        "tarea": tarea,
        "fecha_Hora": fechaHora,
        "userName": userName,
        "comentario": comentario,
        "estado": estado,
        "imagen": imagen.toString() == "{}" ? null : imagen,
      };
}

class CommentPostModel {
  CommentPostModel({
    required this.comment,
    required this.files,
  });

  final CommentModel comment;
  final FilesModel files;
}

class FilesModel {
  FilesModel({
    required this.pictures,
    required this.documents,
    required this.others,
  });

  final List<FilesCommentModel> pictures;
  final List<FilesCommentModel> documents;
  final List<FilesCommentModel> others;
}
