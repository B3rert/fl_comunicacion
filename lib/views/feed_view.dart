import 'package:any_link_preview/any_link_preview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/feed_view_model.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  void initState() {
    super.initState();
    final _vm = Provider.of<FeedViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) => _vm.loadData(context));
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final _vm = Provider.of<FeedViewModel>(context);

    return Scaffold(
      key: scaffoldKey,
      drawer: _MyDrawer(),
      floatingActionButton: _vm.isLoading
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
      body: _vm.isLoading
          ? const LoadWidget()
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 250,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () => _vm.loadData(context),
                    child: ListView(
                      children: [
                        GestureDetector(
                          onTap: () => scaffoldKey.currentState?.openDrawer(),
                          child: CardWidget(
                            color: AppTheme.backroundColor,
                            width: double.infinity,
                            height: 190,
                            raidus: 22,
                            child: _HeaderDrawer(
                              backgroundIcon: AppTheme.primary,
                              textColor: Colors.black,
                              color: AppTheme.backroundColor,
                            ),
                          ),
                        ),
                        if (_vm.posts.isEmpty) const SizedBox(height: 75),
                        if (_vm.posts.isEmpty) const NotFoundWidget(),
                        if (_vm.posts.isNotEmpty)
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _vm.posts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  "post",
                                  arguments: _vm.posts[index],
                                ),
                                child: _Post(
                                  post: _vm.posts[index],
                                  index: index,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: _vm.banners.isEmpty
                          ? const Image(
                              image: AssetImage("assets/banner.png"),
                              fit: BoxFit.cover,
                            )
                          : FadeInImage(
                              image:
                                  NetworkImage(_vm.banners[0].bannerPrincipal),
                              placeholder:
                                  const AssetImage("assets/banner.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/banner.png',
                                  fit: BoxFit.cover,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      height: 250.0,
                      child: IconButton(
                        iconSize: 50,
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: CircleAvatar(
                          backgroundColor: AppTheme.primary,
                          radius: 32,
                          child: _vm.users.isEmpty
                              ? const Text("U")
                              : _vm.users[0].foto == null ||
                                      _vm.users[0].foto == ""
                                  ? Text(_vm.users[0].userName[0].toUpperCase())
                                  : FadeInImage(
                                      placeholder: const AssetImage(
                                        "assets/user.png",
                                      ),
                                      image: NetworkImage(
                                        _vm.users[0].foto,
                                      ),
                                    ),
                        ),
                      ),
                      alignment: const Alignment(-0.9, -0.4),
                    )
                  ],
                )
              ],
            ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({
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

class _MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<FeedViewModel>(context);

    return Drawer(
      backgroundColor: AppTheme.backroundColor,
      child: Column(
        children: [
          _HeaderDrawer(
            color: AppTheme.primary,
            backgroundIcon: AppTheme.backroundColor,
            textColor: Colors.white,
          ),
          Expanded(
            child: _vm.users.isEmpty
                ? ListView(
                    children: const [NotFoundWidget()],
                  )
                : ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _InfoUser(
                        title: "Nombre",
                        subtitle: _vm.users[0].name,
                      ),
                      _InfoUser(
                        title: "Sexo",
                        subtitle: _vm.users[0].sexo.toString(),
                      ),
                      _InfoUser(
                        title: "Celular",
                        subtitle: _vm.users[0].celular.toString(),
                      )
                    ],
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 56,
                color: AppTheme.backroundColorSecondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _vm.logout(context),
                      icon: const Icon(
                        Icons.logout,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class _HeaderDrawer extends StatelessWidget {
  const _HeaderDrawer({
    Key? key,
    required this.color,
    required this.textColor,
    required this.backgroundIcon,
  }) : super(key: key);

  final Color color;
  final Color textColor;
  final Color backgroundIcon;

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<FeedViewModel>(context);

    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: color,
      ),
      accountName: Text(
        _vm.users.isEmpty || _vm.users[0].userName.isEmpty
            ? "No disponible"
            : _vm.users[0].userName,
        style: TextStyle(color: textColor),
      ),
      accountEmail: Text(
        _vm.users.isEmpty || _vm.users[0].eMail.isEmpty
            ? "No disponible"
            : _vm.users[0].eMail,
        style: TextStyle(color: textColor),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: backgroundIcon,
        radius: 32,
        child: _vm.users.isEmpty
            ? const Text(
                "U",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            : _vm.users[0].foto == null || _vm.users[0].foto == ""
                ? Text(_vm.users[0].userName[0].toUpperCase())
                : FadeInImage(
                    placeholder: const AssetImage(
                      "assets/user.png",
                    ),
                    image: NetworkImage(
                      _vm.users[0].foto,
                    ),
                  ),
      ),
    );
  }
}

class _InfoUser extends StatelessWidget {
  const _InfoUser({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle.isEmpty || subtitle.toLowerCase() == 'null'
            ? "No disponible"
            : subtitle,
      ),
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
