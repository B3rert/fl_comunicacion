import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: AppTheme.primary,
      // action: SnackBarAction(
      //   label: 'Aceptar',
      //   onPressed: () => Navigator.pop(context),
      // ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
