import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedViewModel extends ChangeNotifier {
  bool isLoading = false;
  final List<InfoUserModel> users = [];
  final List<BannerModel> banners = [];
  final List<PostModel> posts = [];

  addComment(PostModel post) {
    int indice = posts.indexWhere((item) => item.tarea == post.tarea);
    posts[indice].cantidadComentarios++;
    notifyListeners();
  }

  postInFeed(PostModel post) {
    posts.insert(0, post);
    notifyListeners();
  }

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

    //valid succes response
    if (!res.succes) {
      //stop prosses
      isLoading = false;
      notifyListeners();

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

    BannerService bannerService = BannerService();

    ApiResModel resBanner = await bannerService.getBanner(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //valid succes response
    if (!resBanner.succes) {
      //stop prosses
      isLoading = false;
      notifyListeners();

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

    PostService postService = PostService();

    ApiResModel resPost = await postService.getPosts(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //stop prosses
    isLoading = false;
    notifyListeners();

    //valid succes response
    if (!resPost.succes) {
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

    banners.clear();
    banners.addAll(resBanner.message);

    posts.clear();
    posts.addAll(resPost.message);
  }

  splitText(String texto) {
    RegExp regExp = RegExp(
      r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+",
      caseSensitive: false,
      multiLine: false,
    );

    Iterable<Match> matches = regExp.allMatches(texto);

    List<ElementoTextoModel> elementos = [];
    int lastIndex = 0;

    for (Match match in matches) {
      if (match.start > lastIndex) {
        elementos.add(
          ElementoTextoModel(
            contenido: texto.substring(lastIndex, match.start),
            esEnlace: false,
          ),
        );
      }
      elementos.add(
        ElementoTextoModel(
          contenido: match.group(0)!,
          esEnlace: true,
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < texto.length) {
      elementos.add(
        ElementoTextoModel(
          contenido: texto.substring(lastIndex),
          esEnlace: false,
        ),
      );
    }
    return elementos;
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
