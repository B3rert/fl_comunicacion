import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:fl_comunicacion/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  String token = "";
  String nameUser = "";
  //Map form
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

  bool isSliderDisabledSession = false;
  bool obscureText = true;

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

  logout() {
    Preferences.clearToken();
    token = "";
    nameUser = "";
    notifyListeners();
  }

  //init Session
  login(BuildContext context) async {
    final loginService = Provider.of<LoginService>(context, listen: false);

    //validate form
    // Navigator.pushNamed(context, "home");
    if (isValidForm()) {
      //code if valid true
      LoginModel loginModel =
          LoginModel(user: formValues["user"]!, pass: formValues["pass"]!);

      isLoading = true;
      notifyListeners();

      ApiResModel res = await loginService.postLogin(loginModel);

      isLoading = false;
      notifyListeners();

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

      RespLogin respLogin = res.message;

      if (respLogin.res) {
        //guardar token y nombre de usuario
        token = respLogin.message;
        nameUser = loginModel.user;

        if (isSliderDisabledSession) {
          Preferences.token = token;
          Preferences.userName = nameUser;
        }

        Navigator.pushReplacementNamed(context, "home");
      } else {
        NotificationsService.showSnackbar(respLogin.message);
      }
    }
  }
}
