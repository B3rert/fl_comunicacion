import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:flutter/material.dart';

class FeedView extends StatelessWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 60,
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const CircleAvatar(
            backgroundColor: AppTheme.backroundColorSecondary,
            radius: 32,
            child: FadeInImage(
              placeholder: AssetImage(
                "assets/user.png",
              ),
              image: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/1946/1946429.png",
              ),
            ),
          ),
        ),
      ),
      drawer: const _MyDrawer(
        userEmail: "juanx64wndaowknol",
        userName: "juan",
        userPhotoUrl: "https://cdn-icons-png.flaticon.com/512/1946/1946429.png",
      ),
      body: const Center(
        child: Text('FeedView'),
      ),
    );
  }
}

class _MyDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userPhotoUrl;

  const _MyDrawer({
    required this.userName,
    required this.userEmail,
    required this.userPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backroundColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primary,
            ),
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: AppTheme.backroundColorSecondary,
              radius: 32,
              child: FadeInImage(
                placeholder: AssetImage(
                  "assets/user.png",
                ),
                image: NetworkImage(
                  "https://cdn-icons-png.flaticon.com/512/1946/1946429.png",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // ... más elementos del Drawer
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
                      onPressed: () {},
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
