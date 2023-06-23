import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  //Key dcaffkod global
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  //Mostrar snack bar
  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: AppTheme.primary,
      // action: SnackBarAction(
      //   label: 'Aceptar',
      //   onPressed: () => Navigator.pop(context),
      // ),
    );

    //mosttar snack
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
