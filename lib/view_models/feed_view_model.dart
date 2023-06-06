import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedViewModel extends ChangeNotifier {
  bool isLoading = false;
  final List<InfoUserModel> users = [];

  loadData(BuildContext context) async {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    UserService userService = UserService();

    //load prosses
    isLoading = true;
    notifyListeners();
    //call service
    ApiResModel res = await userService.getInfoUser(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //stop prosses
    isLoading = false;
    notifyListeners();

    //valid succes response
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

    //ad data in list
    users.clear();
    users.addAll(res.message);
  }

  logout(BuildContext context) {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) => AlertWidget(
        title: "¿Estás seguro?",
        description: "Estas a punto de cerrar sesión.",
        onOk: () {
          //Cerrar sesión, limpiar datos
          Navigator.of(context).pop();
          _loginVM.logout();
          Navigator.pushReplacementNamed(context, 'login');
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}
