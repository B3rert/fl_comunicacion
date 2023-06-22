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

    String separator = "/api/";

    url = url.toLowerCase();

    bool containsApi = url.contains(separator);

    if (!containsApi) {
      NotificationsService.showSnackbar("Url invalida");
      return;
    }

    int lastIndex = url.lastIndexOf(separator);
    String result = url.substring(0, lastIndex + separator.length);

    //intsnce service
    HelloService helloService = HelloService();

    isLoading = true;
    notifyListeners();

    ApiResModel res = await helloService.getHello(result);

    isLoading = false;
    notifyListeners();

    if (!res.succes) {
      NotificationsService.showSnackbar(
        "Algo salió mal, intenta mas tarde o verifica que la url ingresada sea correcta.",
      );
      return;
    }

    if (Preferences.urlApi.isEmpty) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      Navigator.pop(context);
    }

    Preferences.urlApi = result;

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
