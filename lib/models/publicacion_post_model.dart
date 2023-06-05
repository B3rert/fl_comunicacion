// To parse this JSON data, do
//
//     final publicacionPostModel = publicacionPostModelFromMap(jsonString);

import 'dart:convert';

class PublicacionPostModel {
  String user;
  String titulo;
  String descripcion;

  PublicacionPostModel({
    required this.user,
    required this.titulo,
    required this.descripcion,
  });

  factory PublicacionPostModel.fromJson(String str) =>
      PublicacionPostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicacionPostModel.fromMap(Map<String, dynamic> json) =>
      PublicacionPostModel(
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
