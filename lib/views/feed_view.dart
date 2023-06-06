import 'package:fl_comunicacion/models/info_user_model.dart';
import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/feed_view_model.dart';
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

    WidgetsBinding.instance?.addPostFrameCallback((_) => _vm.loadData(context));
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    final _vm = Provider.of<FeedViewModel>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: _vm.isLoading
          ? null
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: CircleAvatar(
                  backgroundColor: AppTheme.primary,
                  radius: 32,
                  child: _vm.users.isEmpty
                      ? const Text("U")
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
              ),
            ),
      drawer: _MyDrawer(),
      body: _vm.isLoading
          ? const LoadWidget()
          : RefreshIndicator(
              onRefresh: () => _vm.loadData(context),
              child: _vm.users.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 75),
                        NotFoundWidget(),
                      ],
                    )
                  : ListView(
                      children: [
                        const SizedBox(height: 75),
                      ],
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
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primary,
            ),
            accountName: Text(
              _vm.users.isEmpty || _vm.users[0].userName.isEmpty
                  ? "No disponible"
                  : _vm.users[0].userName,
            ),
            accountEmail: Text(
              _vm.users.isEmpty || _vm.users[0].eMail.isEmpty
                  ? "No disponible"
                  : _vm.users[0].eMail,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppTheme.backroundColorSecondary,
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
