import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel post =
        ModalRoute.of(context)!.settings.arguments as PostModel;

    final _vm = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: _vm.isLoading
          ? const LoadWidget()
          : RefreshIndicator(
              onRefresh: () => _vm.loadData(context, post.tarea),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        PostWidget(post: post, index: 1),
                        // if (_vm.comments.isEmpty) const SizedBox(height: 75),
                        // if (_vm.comments.isEmpty) const NotFoundWidget(),
                        // if (_vm.comments.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _vm.comments.length,
                          itemBuilder: (BuildContext context, int index) {
                            CommentPostModel comment = _vm.comments[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  width: 4.0, // Ancho de la línea
                                  height: 45.0, // Altura de la línea
                                  color: const Color(
                                      0xFFa3a5a7), // Color de la línea
                                ),
                                _CardComment(
                                  comment: comment,
                                  index: 6,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _CardComment extends StatelessWidget {
  const _CardComment({
    required this.comment,
    required this.index,
  });

  final CommentPostModel comment;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _feedVM = Provider.of<FeedViewModel>(context);

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
                          comment.comment.userName,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          _formatDate(comment.comment.fechaHora),
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

            _ContentText(
              elementos: _feedVM.splitText(
                comment.comment.comentario,
              ),
            ),
            const SizedBox(height: 10),
            //TODO:Validar fotos,
            // _MyCarousel(),
            if (comment.files.isNotEmpty) const Text("Archivos"),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: comment.files.length,
              itemBuilder: (BuildContext context, int index) {
                FilesCommentModel file = comment.files[index];
                return Text(file.objetoNombre);
              },
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

class _FileDownload extends StatefulWidget {
  final String fileUrl;

  _FileDownload({required this.fileUrl});

  @override
  _FileDownloadState createState() => _FileDownloadState();
}

class _FileDownloadState extends State<_FileDownload> {
  String? rutaArchivo;

  void descargarBotonPresionado() async {
    final urlArchivo = widget
        .fileUrl; // Utiliza la URL del archivo proporcionada en el constructor
    final ruta = await descargarArchivo(urlArchivo);

    setState(() {
      rutaArchivo = ruta;
    });
  }

  void abrirBotonPresionado() {
    if (rutaArchivo != null) {
      launch(rutaArchivo!);
    }
  }

  Future<String> descargarArchivo(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    final directory = await getExternalStorageDirectory();
    final filePath =
        '${directory!.path}/archivo.txt'; // Cambia "archivo.txt" al nombre del archivo que deseas descargar

    await File(filePath).writeAsBytes(bytes);

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: descargarBotonPresionado,
          child: Text('Descargar archivo'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: abrirBotonPresionado,
          child: Text('Abrir archivo'),
        ),
      ],
    );
  }
}
