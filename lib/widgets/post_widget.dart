import 'package:any_link_preview/any_link_preview.dart';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/services/services.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  final PostModel post;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<FeedViewModel>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      clipBehavior: Clip.antiAlias,
      color: AppTheme.backroundColorSecondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipOval(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: AppTheme.primary,
                      child: Center(
                        child: post.imagen == null
                            ? Text(
                                post.userName[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/user.png',
                                image: post.imagen,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/user.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.userName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          _formatDate(post.fechaHora),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Color(0xFFa3a5a7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              post.descripcion,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            _ContentText(elementos: _vm.splitText(post.observacion1)),
            // const SizedBox(height: 10),
            //TODO:Agregar fotos (Mismos widgets que comentarios),
            const SizedBox(height: 20),

            Text(
              "${post.cantidadComentarios} Comentarios",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13.0,
                color: Color(0xFFa3a5a7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentText extends StatelessWidget {
  final List<ElementoTextoModel> elementos;

  const _ContentText({
    required this.elementos,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: elementos.length,
      itemBuilder: (BuildContext context, int index) {
        final ElementoTextoModel texto = elementos[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: texto.esEnlace
                  ? () async {
                      await Clipboard.setData(
                          ClipboardData(text: texto.contenido));

                      NotificationsService.showSnackbar(
                          "Enlace copiado al portapapeles");
                    }
                  : null,
              child: Text(
                texto.contenido,
                style: texto.esEnlace
                    ? const TextStyle(
                        fontSize: 13,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      )
                    : const TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(height: 10),
            if (texto.esEnlace)
              AnyLinkPreview(
                link: texto.contenido,
                displayDirection: UIDirection.uiDirectionHorizontal,
                cache: const Duration(hours: 1),
                backgroundColor: AppTheme.backroundColor,
                errorWidget: Container(
                  color: AppTheme.backroundColor,
                  child: const Text('Oops!'),
                ),
                errorBody:
                    "https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png",
                errorImage:
                    "asstes/placeimg.jpghttps://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png",
              ),
            if (texto.esEnlace) const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

//Funcion formatear fecha con intl
String _formatDate(String date) {
  var parsedDate = DateTime.parse(date);

  String datetime1 = DateFormat("dd/MM/yyyy hh:mm").format(parsedDate);

  return datetime1;
}
