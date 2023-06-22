import 'package:fl_comunicacion/routes/app_routes.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  //inicializar shared preferences (preferencias de usuario)
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  //inicializar aplicacion
  runApp(const AppState());
}

//Estado de la aplicacion con provider
class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //providers (ViewModels)
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (_) => ApiViewModel()),
        ChangeNotifierProvider(create: (_) => FeedViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
        ChangeNotifierProvider(create: (_) => NewPostViewModel()),
        ChangeNotifierProvider(create: (_) => NewCommentViewModel()),
      ],
      //aplicacion
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    //verificar si hay sesiones guardadas
    if (Preferences.token.isNotEmpty) {
      _loginVM.token = Preferences.token;
      _loginVM.nameUser = Preferences.userName;
    }

    //limpiar preferencias
    // Preferences.clearUrl();
    // Preferences.clearToken();

    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: "Restaurante",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // initialRoute: "home",
      initialRoute: Preferences.baseUrl.isEmpty
          ? "api"
          : Preferences.token.isNotEmpty
              ? AppRoutes.secondRoute
              : AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
