// To parse this JSON data, do
//
//     final filesCommentModel = filesCommentModelFromMap(jsonString);

import 'dart:convert';

class FilesCommentModel {
  int tareaComentarioObjeto;
  int tareaComentario;
  int tarea;
  String fechaHora;
  String userName;
  String objetoNombre;
  int estado;
  dynamic mFechaHora;
  dynamic mUserName;
  dynamic observacion1;
  String urLObjeto;

  FilesCommentModel({
    required this.tareaComentarioObjeto,
    required this.tareaComentario,
    required this.tarea,
    required this.fechaHora,
    required this.userName,
    required this.objetoNombre,
    required this.estado,
    required this.mFechaHora,
    required this.mUserName,
    required this.observacion1,
    required this.urLObjeto,
  });

  factory FilesCommentModel.fromJson(String str) =>
      FilesCommentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilesCommentModel.fromMap(Map<String, dynamic> json) =>
      FilesCommentModel(
        tareaComentarioObjeto: json["tarea_Comentario_Objeto"],
        tareaComentario: json["tarea_Comentario"],
        tarea: json["tarea"],
        fechaHora: json["fecha_Hora"],
        userName: json["userName"],
        objetoNombre: json["objeto_Nombre"],
        estado: json["estado"],
        mFechaHora: json["m_Fecha_Hora"].toString() == "{}"
            ? null
            : json["m_Fecha_Hora"],
        mUserName:
            json["m_UserName"].toString() == "{}" ? null : json["m_UserName"],
        observacion1: json["observacion_1"].toString() == "{}"
            ? null
            : json["observacion_1"],
        urLObjeto: json["urL_Objeto"],
      );

  Map<String, dynamic> toMap() => {
        "tarea_Comentario_Objeto": tareaComentarioObjeto,
        "tarea_Comentario": tareaComentario,
        "tarea": tarea,
        "fecha_Hora": fechaHora,
        "userName": userName,
        "objeto_Nombre": objetoNombre,
        "estado": estado,
        "m_Fecha_Hora": mFechaHora.toString() == "{}" ? null : mFechaHora,
        "m_UserName": mUserName.toString() == "{}" ? null : mUserName,
        "observacion_1": observacion1.toString() == "{}" ? null : observacion1,
        "urL_Objeto": urLObjeto,
      };
}
