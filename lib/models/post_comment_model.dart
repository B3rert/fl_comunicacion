// To parse this JSON data, do
//
//     final postCommentModel = postCommentModelFromMap(jsonString);

import 'dart:convert';

class PostCommentModel {
  int tarea;
  String user;
  String titulo;
  String descripcion;

  PostCommentModel({
    required this.tarea,
    required this.user,
    required this.titulo,
    required this.descripcion,
  });

  factory PostCommentModel.fromJson(String str) =>
      PostCommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostCommentModel.fromMap(Map<String, dynamic> json) =>
      PostCommentModel(
        tarea: json["tarea"],
        user: json["user"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "tarea": tarea,
        "user": user,
        "titulo": titulo,
        "descripcion": descripcion,
      };
}
