import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostViewModel extends ChangeNotifier {
  bool isLoading = false;
  final List<CommentPostModel> comments = [];

  loadData(BuildContext context, int tarea) async {
    final _loginVM = Provider.of<LoginViewModel>(context, listen: false);

    PostService postService = PostService();

    //load prosses
    isLoading = true;
    notifyListeners();
    //call service
    ApiResModel res = await postService.getComments(
      _loginVM.nameUser,
      _loginVM.token,
      tarea,
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

    //ad data in list
    comments.clear();

    for (var comment in res.message) {
      CommentPostModel item = CommentPostModel(comment: comment, files: []);
      comments.add(item);
    }

    for (var comment in comments) {
      ApiResModel resFile = await postService.getFilesComments(
        _loginVM.nameUser,
        _loginVM.token,
        comment.comment.tarea,
        comment.comment.tareaComentario,
      );

      //valid succes response
      if (!resFile.succes) {
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

      List<FilesCommentModel> files = resFile.message;

      //agregar displays a la applicacion correspondientes
      comment.files.addAll(files);
    }

    //stop prosses
    isLoading = false;
    notifyListeners();
  }
}
