import 'package:fl_comunicacion/routes/app_routes.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ApiViewModel()),
        ChangeNotifierProvider(create: (_) => HelloService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => BienvenidaService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => BannerService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    if (Preferences.token.isNotEmpty) {
      _loginVM.token = Preferences.token;
      _loginVM.nameUser = Preferences.userName;
    }

    // Preferences.clearUrl();
    // Preferences.clearToken();

    return MaterialApp(
      scaffoldMessengerKey: NotificationsService.messengerKey,
      title: "Restaurante",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
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
