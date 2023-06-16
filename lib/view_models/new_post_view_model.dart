import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostViewModel extends ChangeNotifier {
  bool isLoading = false;

  //Map form
  final Map<String, String> formValues = {
    'title': '',
    'description': '',
  };

  //Key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //True if form is valid
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  createPost(BuildContext context) async {
    if (!isValidForm()) return;

    PostService postService = PostService();

    isLoading = true;
    notifyListeners();

    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    PostPostModel newPost = PostPostModel(
      user: _loginVM.nameUser,
      titulo: formValues["title"]!,
      descripcion: formValues["description"]!,
    );

    ApiResModel res = await postService.postPost(_loginVM.token, newPost);

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

    List<PostResModel> posts = res.message;

    if (posts.isEmpty) {
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

    NotificationsService.showSnackbar("Publicacion creada correctamente");
    final _feedVM = Provider.of<FeedViewModel>(context, listen: false);

    PostModel post = PostModel(
      tarea: posts[0].tarea,
      descripcion: newPost.titulo,
      fechaIni: posts[0].fechaIni,
      userName: newPost.user,
      observacion1: newPost.descripcion,
      tipoTarea: posts[0].tipoTarea,
      estado: posts[0].estado,
      fechaHora: posts[0].fechaHora,
      cantidadComentarios: 0,
      imagen: _feedVM.users[0].foto,
    );

    _feedVM.postInFeed(post);

    formValues["title"] = "";
    formValues["description"] = "";
  }
}
