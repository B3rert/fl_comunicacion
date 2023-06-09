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

  CommentModel({
    required this.tareaComentario,
    required this.tarea,
    required this.fechaHora,
    required this.userName,
    required this.comentario,
    required this.estado,
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
      );

  Map<String, dynamic> toMap() => {
        "tarea_Comentario": tareaComentario,
        "tarea": tarea,
        "fecha_Hora": fechaHora,
        "userName": userName,
        "comentario": comentario,
        "estado": estado,
      };
}

class CommentPostModel {
  CommentPostModel({
    required this.comment,
    required this.files,
  });

  final CommentModel comment;
  final List<FilesCommentModel> files;
}
