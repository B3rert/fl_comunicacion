import 'package:fl_comunicacion/views/views.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static const secondRoute = 'welcome';
  static Map<String, Widget Function(BuildContext)> routes = {
    secondRoute: (BuildContext context) => const WelcomeView(),
    initialRoute: (BuildContext context) => const LoginView(),
    'api': (BuildContext context) => const ApiView(),
    'feed': (BuildContext context) => const FeedView(),
    'post': (BuildContext context) => const PostView(),
    'newPost': (BuildContext context) => const NewPostView(),
    'newComment': (BuildContext context) => const NewCommentView(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    //print(settings);
    return MaterialPageRoute(
      builder: (BuildContext context) => const WelcomeView(),
    );
  }
}
