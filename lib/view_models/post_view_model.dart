import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostViewModel extends ChangeNotifier {
  bool isLoading = false;
  final List<CommentModel> comments = [];

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

    //ad data in list
    comments.clear();
    comments.addAll(res.message);
  }
}
