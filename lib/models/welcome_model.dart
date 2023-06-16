// To parse this JSON data, do
//
//     final bienvenidaModel = bienvenidaModelFromMap(jsonString);

import 'dart:convert';

class WelcomeModel {
  int tarea;
  String descripcion;
  String fechaIni;
  String fechaFin;
  String userName;
  String observacion1;
  int tipoTarea;
  dynamic cuentaCorrentista;
  dynamic cuentaCta;
  int estado;
  String fechaHora;
  dynamic imagen;

  WelcomeModel({
    required this.tarea,
    required this.descripcion,
    required this.fechaIni,
    required this.fechaFin,
    required this.userName,
    required this.observacion1,
    required this.tipoTarea,
    required this.cuentaCorrentista,
    required this.cuentaCta,
    required this.estado,
    required this.fechaHora,
    required this.imagen,
  });

  factory WelcomeModel.fromJson(String str) =>
      WelcomeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WelcomeModel.fromMap(Map<String, dynamic> json) => WelcomeModel(
        tarea: json["tarea"],
        descripcion: json["descripcion"],
        fechaIni: json["fecha_Ini"],
        fechaFin: json["fecha_Fin"],
        userName: json["userName"],
        observacion1: json["observacion_1"],
        tipoTarea: json["tipo_Tarea"],
        cuentaCorrentista: json["cuenta_Correntista"].toString() == "{}"
            ? null
            : json["cuenta_Correntista"],
        cuentaCta:
            json["cuenta_Cta"].toString() == "{}" ? null : json["cuenta_Cta"],
        estado: json["estado"],
        fechaHora: json["fecha_Hora"],
        imagen: json["imagen"].toString() == "{}" ? null : json["imagen"],
      );

  Map<String, dynamic> toMap() => {
        "tarea": tarea,
        "descripcion": descripcion,
        "fecha_Ini": fechaIni,
        "fecha_Fin": fechaFin,
        "userName": userName,
        "observacion_1": observacion1,
        "tipo_Tarea": tipoTarea,
        "cuenta_Correntista":
            cuentaCorrentista.toString() == '{}' ? null : cuentaCorrentista,
        "cuenta_Cta": cuentaCta.toString() == '{}' ? null : cuentaCta,
        "estado": estado,
        "fecha_Hora": fechaHora,
        "imagen": imagen.toString() == "{}" ? null : imagen,
      };
}
