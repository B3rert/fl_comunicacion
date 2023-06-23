import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedViewModel extends ChangeNotifier {
  //controlar proceso
  bool isLoading = false;
  //informacion del usario
  final List<InfoUserModel> users = [];
  //Banner
  final List<BannerModel> banners = [];
  //publicaciones
  final List<PostModel> posts = [];

  //agreagar comentario a una publicacion
  addComment(PostModel post) {
    //buscar cual es la publicacon (indice en la lista)
    int indice = posts.indexWhere((item) => item.tarea == post.tarea);
    //Sumar 1 a la cantidad de comentarios de la publicacion
    posts[indice].cantidadComentarios++;
    notifyListeners();
  }

  //Agreagar una nueva publicacion
  postInFeed(PostModel post) {
    //en el indice 0 agregar la nueva publicacion
    posts.insert(0, post);
    notifyListeners();
  }

  //caragar datos necesarios para la pantalla (Servicios)
  loadData(BuildContext context) async {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    UserService userService = UserService();

    //load prosses
    isLoading = true;
    notifyListeners();
    //call service obtener Informacion de usuario
    ApiResModel res = await userService.getInfoUser(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //valid succes response
    if (!res.succes) {
      //stop prosses
      isLoading = false;
      notifyListeners();
      //si algo salio mal mostrar alerta
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

    //ejecutar servicio para obtener banner
    ApiResModel resBanner = await bannerService.getBanner(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //valid succes response
    if (!resBanner.succes) {
      //stop prosses
      isLoading = false;
      notifyListeners();

      //si algo salio mal mostrar mensaje
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

    //Uso del servicio para obtener publicaciones
    ApiResModel resPost = await postService.getPosts(
      _loginVM.nameUser,
      _loginVM.token,
    );

    //stop prosses
    isLoading = false;
    notifyListeners();

    //valid succes response
    if (!resPost.succes) {
      //si algo salio mal mostrar alerta
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

    //agreagar datos encontrados a lista globales
    users.clear();
    users.addAll(res.message);

    banners.clear();
    banners.addAll(resBanner.message);

    posts.clear();
    posts.addAll(resPost.message);
  }

  //buscar url en un texto
  splitText(String texto) {
    //expresion regular para validar urls
    RegExp regExp = RegExp(
      r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+",
      caseSensitive: false,
      multiLine: false,
    );

    //buscar si en el texto hay url
    Iterable<Match> matches = regExp.allMatches(texto);

    //elementos contiene el texto y urls
    List<ElementoTextoModel> elementos = [];
    int lastIndex = 0;

    //evaluar expresion regular
    for (Match match in matches) {
      if (match.start > lastIndex) {
        //su el texto no es enlace agregar
        elementos.add(
          ElementoTextoModel(
            contenido: texto.substring(lastIndex, match.start),
            esEnlace: false,
          ),
        );
      }
      //si el texto es enlace agregar
      elementos.add(
        ElementoTextoModel(
          contenido: match.group(0)!,
          esEnlace: true,
        ),
      );
      lastIndex = match.end;
    }
    //si el texto no es enlace agregar
    if (lastIndex < texto.length) {
      elementos.add(
        ElementoTextoModel(
          contenido: texto.substring(lastIndex),
          esEnlace: false,
        ),
      );
    }
    //Retorna lista de textos y enlaces
    return elementos;
  }

  //navegar a detalles de la publicacion (pantalla)
  navigatePost(BuildContext context, PostModel post) {
    final _postVM = Provider.of<PostViewModel>(
      context,
      listen: false,
    );

    //Cragar detalles de la publicacion (comentarios, imagenes...)
    _postVM.loadData(context, post.tarea);

    //navegar a oantalla detalles
    Navigator.pushNamed(
      context,
      "post",
      arguments: post,
    );
  }

  //Cerrar sesion
  logout(BuildContext context) {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    //mostatr dialogo de confirmacion
    showDialog(
      context: context,
      builder: (context) => AlertWidget(
        title: "¿Estás seguro?",
        description: "Estas a punto de cerrar sesión.",
        onOk: () {
          //Cerrar sesión, limpiar datos
          Navigator.of(context).pop();
          _loginVM.logout();
          Navigator.of(context).pushNamedAndRemoveUntil(
            'login', // Ruta a la que se redirigirá después de cerrar sesión
            (Route<dynamic> route) =>
                false, // Condición para eliminar todas las rutas anteriores
          );
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}
