import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class HomeViewModel extends ChangeNotifier {
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
