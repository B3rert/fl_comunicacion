import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  //manejar flujo del procesp
  bool isLoading = false;
  //token del usuario
  String token = "";
  //nombre del usuario
  String nameUser = "";
  //conytrolar seion permanente
  bool isSliderDisabledSession = false;
  //ocultar y mostrar contraseña
  bool obscureText = true;
  //formulario login
  final Map<String, String> formValues = {
    'user': '',
    'pass': '',
  };

  //Key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //True if form is valid
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // Toggles the password show status
  void toggle() {
    obscureText = !obscureText;
    notifyListeners();
  }

  //disableSession
  void disableSession(bool value) {
    isSliderDisabledSession = value;
    notifyListeners();
  }

  //navigate api url config
  navigateConfigApi(BuildContext context) {
    Navigator.pushNamed(context, "api");
  }

  //cerrar Sesion
  logout() {
    //limpiar datos en preferencias
    Preferences.clearToken();
    token = "";
    nameUser = "";
    notifyListeners();
  }

  //init Session
  login(BuildContext context) async {
    LoginService loginService = LoginService();

    //validate form
    // Navigator.pushNamed(context, "home");
    if (isValidForm()) {
      //code if valid true
      LoginModel loginModel = LoginModel(
        user: formValues["user"]!,
        pass: formValues["pass"]!,
      );

      //iniciar proceso
      isLoading = true;
      notifyListeners();

      //uso servicio login
      ApiResModel res = await loginService.postLogin(loginModel);

      //finalizar proceso
      isLoading = false;
      notifyListeners();

      //validar respuesta del servico, si es incorrecta
      if (!res.succes) {
        showDialog(
          context: context,
          builder: (context) => AlertInfoWidget(
            title: "Algo salió mal",
            description:
                "No se pudo completar el proceso de conexión al servicio. Por favor, inténtalo de nuevo más tarde.",
            onOk: () => Navigator.pop(context),
          ),
        );
        return;
      }

      //mapear respuesta servicio
      RespLogin respLogin = res.message;

      //si el usuaro es correcto
      if (respLogin.success) {
        //guardar token y nombre de usuario
        token = respLogin.res;
        nameUser = loginModel.user;

        //si la sesion es permanente guardar en preferencias el token
        if (isSliderDisabledSession) {
          Preferences.token = token;
          Preferences.userName = nameUser;
        }

        //navegar a home
        Navigator.pushReplacementNamed(context, "home");
      } else {
        //si el uario es incorrecto
        NotificationsService.showSnackbar(respLogin.res);
      }
    }
  }
}
