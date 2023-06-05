// To parse this JSON data, do
//
//     final publicacionGetModel = publicacionGetModelFromMap(jsonString);

import 'dart:convert';

class PublicacionGetModel {
  int tarea;
  String descripcion;
  String fechaIni;
  String fechaFin;
  dynamic referencia;
  String userName;
  String observacion1;
  int tipoTarea;
  dynamic cuentaCorrentista;
  dynamic cuentaCta;
  dynamic cantidadContacto;
  dynamic nombreContacto;
  dynamic tipoDocumento;
  dynamic idDocumento;
  dynamic refSerie;
  dynamic fechaDocumento;
  dynamic elementoAsignado;
  dynamic actividadPaso;
  dynamic ejecutado;
  dynamic ejecutadoPor;
  dynamic ejecutadoFecha;
  dynamic ejecutadoFechaHora;
  dynamic mFechaHora;
  dynamic mUserName;
  dynamic producto;
  int estado;
  String fechaHora;
  int empresa;
  int nivelPrioridad;
  dynamic tareaPadre;
  dynamic tiempoEstimadoTipoPeriocidad;
  dynamic tiempoEstimado;
  dynamic observacion2;

  PublicacionGetModel({
    required this.tarea,
    required this.descripcion,
    required this.fechaIni,
    required this.fechaFin,
    required this.referencia,
    required this.userName,
    required this.observacion1,
    required this.tipoTarea,
    required this.cuentaCorrentista,
    required this.cuentaCta,
    required this.cantidadContacto,
    required this.nombreContacto,
    required this.tipoDocumento,
    required this.idDocumento,
    required this.refSerie,
    required this.fechaDocumento,
    required this.elementoAsignado,
    required this.actividadPaso,
    required this.ejecutado,
    required this.ejecutadoPor,
    required this.ejecutadoFecha,
    required this.ejecutadoFechaHora,
    required this.mFechaHora,
    required this.mUserName,
    required this.producto,
    required this.estado,
    required this.fechaHora,
    required this.empresa,
    required this.nivelPrioridad,
    required this.tareaPadre,
    required this.tiempoEstimadoTipoPeriocidad,
    required this.tiempoEstimado,
    required this.observacion2,
  });

  factory PublicacionGetModel.fromJson(String str) =>
      PublicacionGetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicacionGetModel.fromMap(Map<String, dynamic> json) =>
      PublicacionGetModel(
        tarea: json["tarea"],
        descripcion: json["descripcion"],
        fechaIni: json["fecha_Ini"],
        fechaFin: json["fecha_Fin"],
        referencia:
            json["referencia"].toString() == "{}" ? null : json["referencia"],
        userName: json["userName"],
        observacion1: json["observacion_1"],
        tipoTarea: json["tipo_Tarea"],
        cuentaCorrentista: json["cuenta_Correntista"].toString() == "{}"
            ? null
            : json["cuenta_Correntista"],
        cuentaCta:
            json["cuenta_Cta"].toString() == "{}" ? null : json["cuenta_Cta"],
        cantidadContacto: json["cantidad_Contacto"].toString() == "{}"
            ? null
            : json["cantidad_Contacto"],
        nombreContacto: json["nombre_Contacto"].toString() == "{}"
            ? null
            : json["nombre_Contacto"],
        tipoDocumento: json["tipo_Documento"].toString() == "{}"
            ? null
            : json["tipo_Documento"],
        idDocumento: json["id_Documento"].toString() == "{}"
            ? null
            : json["id_Documento"],
        refSerie:
            json["ref_Serie"].toString() == "{}" ? null : json["ref_Serie"],
        fechaDocumento: json["fecha_Documento"].toString() == "{}"
            ? null
            : json["fecha_Documento"],
        elementoAsignado: json["elemento_Asignado"].toString() == "{}"
            ? null
            : json["elemento_Asignado"],
        actividadPaso: json["actividad_Paso"].toString() == "{}"
            ? null
            : json["actividad_Paso"],
        ejecutado:
            json["ejecutado"].toString() == "{}" ? null : json["ejecutado"],
        ejecutadoPor: json["ejecutado_Por"].toString() == "{}"
            ? null
            : json["ejecutado_Por"],
        ejecutadoFecha: json["ejecutado_Fecha"].toString() == "{}"
            ? null
            : json["ejecutado_Fecha"],
        ejecutadoFechaHora: json["ejecutado_Fecha_Hora"].toString() == "{}"
            ? null
            : json["ejecutado_Fecha_Hora"],
        mFechaHora: json["m_Fecha_Hora"].toString() == "{}"
            ? null
            : json["m_Fecha_Hora"],
        mUserName:
            json["m_UserName"].toString() == "{}" ? null : json["m_UserName"],
        producto: json["producto"].toString() == "{}" ? null : json["producto"],
        estado: json["estado"],
        fechaHora: json["fecha_Hora"],
        empresa: json["empresa"],
        nivelPrioridad: json["nivel_Prioridad"],
        tareaPadre: json["tarea_Padre"].toString() == "{}"
            ? null
            : json["nivel_Prioridad"],
        tiempoEstimadoTipoPeriocidad:
            json["tiempo_Estimado_Tipo_Periocidad"].toString() == "{}"
                ? null
                : json["tiempo_Estimado_Tipo_Periocidad"],
        tiempoEstimado: json["tiempo_Estimado"].toString() == "{}"
            ? null
            : json["tiempo_Estimado"],
        observacion2: json["observacion_2"].toString() == "{}"
            ? null
            : json["observacion_2"],
      );

  Map<String, dynamic> toMap() => {
        "tarea": tarea,
        "descripcion": descripcion,
        "fecha_Ini": fechaIni,
        "fecha_Fin": fechaFin,
        "referencia": referencia.toString() == "{}" ? null : referencia,
        "userName": userName,
        "observacion_1": observacion1,
        "tipo_Tarea": tipoTarea,
        "cuenta_Correntista":
            cuentaCorrentista.toString() == "{}" ? null : cuentaCorrentista,
        "cuenta_Cta": cuentaCta.toString() == "{}" ? null : cuentaCta,
        "cantidad_Contacto":
            cantidadContacto.toString() == "{}" ? null : cantidadContacto,
        "nombre_Contacto":
            nombreContacto.toString() == "{}" ? null : nombreContacto,
        "tipo_Documento":
            tipoDocumento.toString() == "{}" ? null : tipoDocumento,
        "id_Documento": idDocumento.toString() == "{}" ? null : idDocumento,
        "ref_Serie": refSerie.toString() == "{}" ? null : refSerie,
        "fecha_Documento":
            fechaDocumento.toString() == "{}" ? null : fechaDocumento,
        "elemento_Asignado":
            elementoAsignado.toString() == "{}" ? null : elementoAsignado,
        "actividad_Paso":
            actividadPaso.toString() == "{}" ? null : actividadPaso,
        "ejecutado": ejecutado.toString() == "{}" ? null : ejecutado,
        "ejecutado_Por": ejecutadoPor.toString() == "{}" ? null : ejecutadoPor,
        "ejecutado_Fecha":
            ejecutadoFecha.toString() == "{}" ? null : ejecutadoFecha,
        "ejecutado_Fecha_Hora":
            ejecutadoFechaHora.toString() == "{}" ? null : ejecutadoFechaHora,
        "m_Fecha_Hora": mFechaHora.toString() == "{}" ? null : mFechaHora,
        "m_UserName": mUserName.toString() == "{}" ? null : mUserName,
        "producto": producto.toString() == "{}" ? null : producto,
        "estado": estado,
        "fecha_Hora": fechaHora,
        "empresa": empresa,
        "nivel_Prioridad": nivelPrioridad,
        "tarea_Padre": tareaPadre.toString() == "{}" ? null : tareaPadre,
        "tiempo_Estimado_Tipo_Periocidad":
            tiempoEstimadoTipoPeriocidad.toString() == "{}"
                ? null
                : tiempoEstimadoTipoPeriocidad,
        "tiempo_Estimado":
            tiempoEstimado.toString() == "{}" ? null : tiempoEstimado,
        "observacion_2": observacion2.toString() == "{}" ? null : observacion2,
      };
}
