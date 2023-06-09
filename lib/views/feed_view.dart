import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
              onPressed: () => Navigator.pushNamed(context, "newPost"),
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
                          child: const _CardUser(),
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
                              PostModel post = _vm.posts[index];
                              return GestureDetector(
                                onTap: () => _vm.navigatePost(context, post),
                                child: PostWidget(
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
                        onPressed: () => scaffoldKey.currentState?.openDrawer(),
                        icon: _UserCircle(),
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

class _CardUser extends StatelessWidget {
  const _CardUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      color: AppTheme.backroundColor,
      width: double.infinity,
      height: 190,
      raidus: 22,
      child: _HeaderDrawer(
        backgroundIcon: AppTheme.primary,
        textColor: Colors.black,
        color: AppTheme.backroundColor,
      ),
    );
  }
}

class _UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<FeedViewModel>(context);

    return ClipOval(
      child: Container(
        width: 100,
        height: 100,
        color: AppTheme.primary,
        child: Center(
          child: _vm.users.isEmpty
              ? const Text(
                  "U",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              : _vm.users[0].foto == null
                  ? Text(
                      _vm.users[0].userName[0].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    )
                  : FadeInImage.assetNetwork(
                      placeholder: 'assets/user.png',
                      image: _vm.users[0].foto,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/user.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
        ),
      ),
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
      currentAccountPicture: _UserCircle(),
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
