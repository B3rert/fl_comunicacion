import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCommentViewModel extends ChangeNotifier {
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

  createComment(
    BuildContext context,
    PostModel post,
  ) async {
    if (!isValidForm()) return;

    PostService postService = PostService();

    isLoading = true;
    notifyListeners();

    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    PostCommentModel comment = PostCommentModel(
      tarea: post.tarea,
      user: _loginVM.nameUser,
      titulo: formValues["title"]!,
      descripcion: formValues["description"]!,
    );

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

    List<CommentModel> comments = res.message;

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

    NotificationsService.showSnackbar("Comentario creado correctamente");
    final _feedVM = Provider.of<FeedViewModel>(context, listen: false);
    final _postVM = Provider.of<PostViewModel>(context, listen: false);

    _feedVM.addComment(post);
    _postVM.addComment(comments[0], post);

    formValues["title"] = "";
  }
}
