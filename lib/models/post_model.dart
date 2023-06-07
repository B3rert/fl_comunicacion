// To parse this JSON data, do
//
//     final postModel = postModelFromMap(jsonString);

import 'dart:convert';

class PostModel {
  int tarea;
  String descripcion;
  String fechaIni;
  String userName;
  String observacion1;
  int tipoTarea;
  int estado;
  String fechaHora;
  int cantidadComentarios;

  PostModel({
    required this.tarea,
    required this.descripcion,
    required this.fechaIni,
    required this.userName,
    required this.observacion1,
    required this.tipoTarea,
    required this.estado,
    required this.fechaHora,
    required this.cantidadComentarios,
  });

  factory PostModel.fromJson(String str) => PostModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
        tarea: json["tarea"],
        descripcion: json["descripcion"],
        fechaIni: json["fecha_Ini"],
        userName: json["userName"],
        observacion1: json["observacion_1"],
        tipoTarea: json["tipo_Tarea"],
        estado: json["estado"],
        fechaHora: json["fecha_Hora"],
        cantidadComentarios: json["cantidad_Comentarios"],
      );

  Map<String, dynamic> toMap() => {
        "tarea": tarea,
        "descripcion": descripcion,
        "fecha_Ini": fechaIni,
        "userName": userName,
        "observacion_1": observacion1,
        "tipo_Tarea": tipoTarea,
        "estado": estado,
        "fecha_Hora": fechaHora,
        "cantidad_Comentarios": cantidadComentarios,
      };
}
