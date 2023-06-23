import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostViewModel extends ChangeNotifier {
  //Manejar inicio y fin del proceso
  bool isLoading = false;
  //Comentarios
  final List<CommentPostModel> comments = [];

  //agreagar comentarios a la publicacion
  addComment(
    CommentModel comment,
    PostModel post,
  ) {
    //Agregar comentarios vacios
    comments.add(
      CommentPostModel(
        comment: comment,
        files: FilesModel(
          pictures: [],
          documents: [],
          others: [],
        ),
      ),
    );
    notifyListeners();
  }

  //Caragar datos de la pantalla detalles publicacion (post)
  loadData(
    BuildContext context,
    int tarea,
  ) async {
    final _loginVM = Provider.of<LoginViewModel>(
      context,
      listen: false,
    );

    //instacncia del servicio
    PostService postService = PostService();

    //load prosses
    isLoading = true;
    notifyListeners();
    //call service obtener comentarios
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

    //agreagar comentario a la publicacion
    for (var comment in res.message) {
      CommentPostModel item = CommentPostModel(
        comment: comment,
        files: FilesModel(
          pictures: [],
          documents: [],
          others: [],
        ),
      );
      comments.add(item);
    }

    //buscar archivos adjuntos a comentarios
    for (var comment in comments) {
      //consumo del servicio
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

      //separar tipos de archivos
      List<FilesCommentModel> files = resFile.message;
      List<FilesCommentModel> imagenes = [];
      List<FilesCommentModel> otrosArchivos = [];
      List<FilesCommentModel> objetosSinExtension = [];

      //Buscar tipos de archivos
      for (FilesCommentModel objeto in files) {
        if (objeto.objetoNombre.toLowerCase().endsWith('.jpg') ||
            objeto.objetoNombre.toLowerCase().endsWith('.png') ||
            objeto.objetoNombre.toLowerCase().endsWith('.gif') ||
            objeto.objetoNombre.toLowerCase().endsWith('.jpeg')) {
          imagenes.add(objeto);
        } else if (objeto.objetoNombre.toLowerCase().contains('.')) {
          otrosArchivos.add(objeto);
        } else {
          objetosSinExtension.add(objeto);
        }
      }

      //agregar tipos de archivos encontrados
      comment.files.pictures.addAll(imagenes);
      comment.files.documents.addAll(otrosArchivos);
      comment.files.pictures.addAll(objetosSinExtension);
    }

    //stop prosses
    isLoading = false;
    notifyListeners();
  }
}
