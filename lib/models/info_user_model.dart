// To parse this JSON data, do
//
//     final infoUserModel = infoUserModelFromMap(jsonString);

import 'dart:convert';

class InfoUserModel {
  String userName;
  String name;
  String description;
  bool disable;
  dynamic sexo;
  dynamic celular;
  String eMail;
  dynamic foto;

  InfoUserModel({
    required this.userName,
    required this.name,
    required this.description,
    required this.disable,
    required this.sexo,
    required this.celular,
    required this.eMail,
    required this.foto,
  });

  factory InfoUserModel.fromJson(String str) =>
      InfoUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoUserModel.fromMap(Map<String, dynamic> json) => InfoUserModel(
        userName: json["userName"],
        name: json["name"],
        description: json["description"],
        disable: json["disable"],
        sexo: json["sexo"].toString() == "{}" ? null : json["sexo"],
        celular: json["celular"].toString() == "{}" ? null : json["celular"],
        eMail: json["eMail"],
        foto: json["foto"].toString() == "{}" ? null : json["foto"],
      );

  Map<String, dynamic> toMap() => {
        "userName": userName,
        "name": name,
        "description": description,
        "disable": disable,
        "sexo": sexo.toString() == "{}" ? null : sexo,
        "celular": celular.toString() == "{}" ? null : celular,
        "eMail": eMail,
        "foto": foto.toString() == "{}" ? null : foto,
      };
}
