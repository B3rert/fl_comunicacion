// To parse this JSON data, do
//
//     final postPostModel = postPostModelFromMap(jsonString);

import 'dart:convert';

class PostPostModel {
  String user;
  String titulo;
  String descripcion;

  PostPostModel({
    required this.user,
    required this.titulo,
    required this.descripcion,
  });

  factory PostPostModel.fromJson(String str) =>
      PostPostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostPostModel.fromMap(Map<String, dynamic> json) => PostPostModel(
        user: json["user"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "user": user,
        "titulo": titulo,
        "descripcion": descripcion,
      };
}
