import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostViewModel extends ChangeNotifier {
  //Cargar procesos
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

  //crear nueva publicacion
  createPost(BuildContext context) async {
    //validar formulario
    if (!isValidForm()) return;

    //instancia del servico
    PostService postService = PostService();

    //iniciar proceso
    isLoading = true;
    notifyListeners();

    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    //objeto publicacion
    PostPostModel newPost = PostPostModel(
      user: _loginVM.nameUser,
      titulo: formValues["title"]!,
      descripcion: formValues["description"]!,
    );

    //Uso del servicio crear nueva publicacion
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

    //publicacion que se creo devuleta por el servico
    List<PostResModel> posts = res.message;

    //si no hay publicacion en la respuesta no se creo la publicacion
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

    //si se creo la publicacion mosttar mensaje
    NotificationsService.showSnackbar("Publicacion creada correctamente");
    final _feedVM = Provider.of<FeedViewModel>(context, listen: false);

    //Nueva publicacion
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

    //agregar nueva publicacion a la pantalla pulicaciones
    _feedVM.postInFeed(post);

    //limmpiar formulario
    formValues["title"] = "";
    formValues["description"] = "";
  }
}
