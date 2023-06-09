import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:flutter/material.dart';
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/user.png"),
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
            const SizedBox(height: 10),
            //TODO:Validar fotos,
            if (index > 1) _MyCarousel(),
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
            Text(
              texto.contenido,
              style: const TextStyle(fontSize: 13),
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
                errorImage:
                    "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg",
              ),
            if (texto.esEnlace) const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

class _MyCarousel extends StatelessWidget {
  //TODO: revisar error en imagenes
  final List<String> images = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/640px-No-Image-Placeholder.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/640px-No-Image-Placeholder.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/640px-No-Image-Placeholder.svg.png',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        pageSnapping: true,
      ),
      items: images.map((String image) {
        return Builder(
          builder: (BuildContext context) {
            return FadeInImage(
              image: NetworkImage(image),
              placeholder: const AssetImage("assets/load.gif"),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/placeimg.jpg',
                  fit: BoxFit.cover,
                );
              },
              fit: BoxFit.cover,
            );
          },
        );
      }).toList(),
    );
  }
}

//Funcion formatear fecha con intl
String _formatDate(String date) {
  var parsedDate = DateTime.parse(date);

  String datetime1 = DateFormat("dd/MM/yyyy hh:mm").format(parsedDate);

  return datetime1;
}