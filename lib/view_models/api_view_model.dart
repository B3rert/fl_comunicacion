import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';

class ApiViewModel extends ChangeNotifier {
  bool isLoading = false;
  String url = "";
  List<String> valueUrl = [];
  //Key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //True if form is valid
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  connectService(BuildContext context) async {
    if (!isValidForm()) return;

    valueUrl.clear();
    valueUrl = url.toLowerCase().split("/");
    String server = "";
    String path = "";
    String prefix = "";
    int finalApiWord = -1;

    prefix = valueUrl[0];
    server = valueUrl[2];

    //eliminar primeras pociciones
    for (var i = 0; i < 3; i++) {
      valueUrl.removeAt(0);
    }

    //find final word api
    for (var i = 0; i < valueUrl.length; i++) {
      if (valueUrl[i] == "api") {
        finalApiWord = i;
      }
    }

    //si no hay palabra api url invalida
    if (finalApiWord == -1) {
      NotificationsService.showSnackbar("Url invalida");
      return;
    }

    //si el indice es 0 no hay path
    if (finalApiWord > 0) {
      //si hay path
      deleteWords(finalApiWord);
      path = valueUrl.join("/");
    }

    //intsnce service
    HelloService helloService = HelloService();

    isLoading = true;
    notifyListeners();

    ApiResModel res = await helloService.getHello(server, path);

    isLoading = false;
    notifyListeners();

    if (!res.succes) {
      NotificationsService.showSnackbar(
        "Algo salió mal, intenta mas tarde o verifica que la url ingresada sea correcta.",
      );
      return;
    }

    if (Preferences.baseUrl.isEmpty) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      Navigator.pop(context);
    }

    //Guardar valores
    Preferences.path = path;
    Preferences.baseUrl = server;
    Preferences.prefix = prefix;

    NotificationsService.showSnackbar(
      "Url agregada correctamente.",
    );
  }

  //eliminar ultimos valores hasta el indice que tnega finalApiWord
  deleteWords(int index) {
    if (valueUrl.length - 1 >= index) {
      valueUrl.removeAt(valueUrl.length - 1);
      deleteWords(index);
    }
  }
}
