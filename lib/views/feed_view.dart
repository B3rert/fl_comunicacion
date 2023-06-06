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
      drawer: Drawer(),
      body: Center(
        child: Text('FeedView'),
      ),
    );
  }
}
