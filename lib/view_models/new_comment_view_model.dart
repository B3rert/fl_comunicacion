import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCommentViewModel extends ChangeNotifier {
  //manejar inicio y fin del proceso
  bool isLoading = false;

  //Formulario crear publicacion o comentario
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

  //crear un n nuevo comentario
  createComment(
    BuildContext context,
    PostModel post,
  ) async {
    //validar formualrio
    if (!isValidForm()) return;

    //nueva instancia del servicio
    PostService postService = PostService();

    //iniciar proceso
    isLoading = true;
    notifyListeners();

    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    //Objeto nuevo comentario
    PostCommentModel comment = PostCommentModel(
      tarea: post.tarea,
      user: _loginVM.nameUser,
      titulo: formValues["title"]!,
      descripcion: formValues["description"]!,
    );

    //usao del servicio, crear comentario
    ApiResModel res = await postService.posComment(_loginVM.token, comment);

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

    //el servicio devuleve el comentario creado, asignar a variable
    List<CommentModel> comments = res.message;

    //si no hay commentario en la respuesta no se creó el comentario
    if (comments.isEmpty) {
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

    //Mostrar mensaje si se creo el comentario
    NotificationsService.showSnackbar("Comentario creado correctamente");
    //actualizar view models
    final _feedVM = Provider.of<FeedViewModel>(context, listen: false);
    final _postVM = Provider.of<PostViewModel>(context, listen: false);

    //agreagar commmenatrio a la pantalla cometarios
    _feedVM.addComment(post);
    //sumar comentario a la publicacion original
    _postVM.addComment(comments[0], post);

    //limpiar campo
    formValues["title"] = "";
  }
}
