import 'package:fl_comunicacion/views/views.dart';
import 'package:flutter/material.dart';

//rutas de navegacion
class AppRoutes {
  //ruta incial
  static const initialRoute = 'login';
  //despues de ruta incial
  static const secondRoute = 'welcome';
  //otras rutas
  static Map<String, Widget Function(BuildContext)> routes = {
    secondRoute: (BuildContext context) => const WelcomeView(),
    initialRoute: (BuildContext context) => const LoginView(),
    'api': (BuildContext context) => const ApiView(),
    'feed': (BuildContext context) => const FeedView(),
    'post': (BuildContext context) => const PostView(),
    'newPost': (BuildContext context) => const NewPostView(),
    'newComment': (BuildContext context) => const NewCommentView(),
  };

  //en caso de ruta incorrecta
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    //print(settings);
    return MaterialPageRoute(
      builder: (BuildContext context) => const WelcomeView(),
    );
  }
}
