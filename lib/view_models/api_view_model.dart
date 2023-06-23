import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';

class ApiViewModel extends ChangeNotifier {
  //loading control
  bool isLoading = false;
  //input url
  String url = "";
  //Key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //True if form is valid
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //validar si la url ingresada es valida y guardarla
  connectService(BuildContext context) async {
    //validar formulario
    if (!isValidForm()) return;

    //la url debe contener por lo menos un "/api/" para ser una url valida
    String separator = "/api/";

    //convertir url a minusculas
    url = url.toLowerCase();

    //existe "/api/" retorna verdadero
    bool containsApi = url.contains(separator);

    //si es falso mostrar mensaje
    if (!containsApi) {
      NotificationsService.showSnackbar("Url invalida");
      return;
    }

    //buscar el ultimo indice donde encuentre "/api/"
    int lastIndex = url.lastIndexOf(separator);
    //Eliminar el resto de la url despues del ultimo "/api/"
    String result = url.substring(0, lastIndex + separator.length);

    //intsnce service
    HelloService helloService = HelloService();

    //iniciar proceso
    isLoading = true;
    notifyListeners();

    //usar servicio api hello
    ApiResModel res = await helloService.getHello(result);

    //terminar proceso
    isLoading = false;
    notifyListeners();

    //verificar respuesta del servicio si es incorrecta
    if (!res.succes) {
      NotificationsService.showSnackbar(
        "Algo salió mal, intenta mas tarde o verifica que la url ingresada sea correcta.",
      );
      return;
    }

    //Si es la primera configuracion navegar a login
    //sino regresar
    if (Preferences.urlApi.isEmpty) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      Navigator.pop(context);
    }

    //guardar url en preferencias
    Preferences.urlApi = result;

    //Mostrar mensaje correcto
    NotificationsService.showSnackbar(
      "Url agregada correctamente.",
    );
  }
}
