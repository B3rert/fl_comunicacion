import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel post =
        ModalRoute.of(context)!.settings.arguments as PostModel;

    final _vm = Provider.of<PostViewModel>(context);

    return Scaffold(
      floatingActionButton: _vm.isLoading
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                context,
                "newComment",
                arguments: post,
              ),
              child: const Icon(Icons.add_comment),
            ),
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
    final _vm = Provider.of<PostViewModel>(context);

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
                        child: comment.comment.imagen == null
                            ? Text(
                                comment.comment.userName[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/user.png',
                                image: comment.comment.imagen,
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
            if (comment.files.pictures.isNotEmpty)
              _MyCarousel(images: comment.files.pictures),
            if (comment.files.documents.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: comment.files.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  FilesCommentModel file = comment.files.documents[index];
                  return _CardFile(file: file);
                },
              ),
            if (comment.files.others.isNotEmpty)
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: comment.files.others.length,
                itemBuilder: (BuildContext context, int index) {
                  FilesCommentModel file = comment.files.others[index];
                  return Text(file.objetoNombre);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _CardFile extends StatefulWidget {
  const _CardFile({
    super.key,
    required this.file,
  });

  final FilesCommentModel file;

  @override
  State<_CardFile> createState() => _CardFileState();
}

class _CardFileState extends State<_CardFile> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        widget.file.objetoNombre,
        style: const TextStyle(fontSize: 13),
      ),
      trailing: const Icon(Icons.open_in_new),
      leading: const Icon(Icons.insert_drive_file),
      onTap: () => setState(() {
        _launched = _launchInBrowser(
          Uri.parse(widget.file.urLObjeto),
        );
      }),
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

class _MyCarousel extends StatefulWidget {
  final List<FilesCommentModel> images;

  const _MyCarousel({required this.images});

  @override
  State<_MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<_MyCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.images.map((FilesCommentModel image) {
            return Builder(
              builder: (BuildContext context) {
                return FadeInImage(
                  image: NetworkImage(image.urLObjeto),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map((item) {
            int index = widget.images.indexOf(item);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? AppTheme.primary : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

//Funcion formatear fecha con intl
String _formatDate(String date) {
  var parsedDate = DateTime.parse(date);

  String datetime1 = DateFormat("dd/MM/yyyy hh:mm").format(parsedDate);

  return datetime1;
}
