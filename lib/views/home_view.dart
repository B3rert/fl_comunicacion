import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'feed'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
          child: CardWidget(
            width: double.infinity,
            height: 70,
            raidus: 20,
            child: Container(
              color: AppTheme.primary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Siguiente",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.trending_flat,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 75),
            const Text(
              "TITUTLO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                clipBehavior: Clip.antiAlias,
                color: AppTheme.backroundColorSecondary,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Incididunt qui aliqua veniam sunt magna ipsum laboris duis aliqua dolore culpa. Voluptate irure veniam proident fugiat proident irure ut officia culpa tempor nisi in. Dolore incididunt dolor veniam ad. Deserunt ullamco anim anim aliquip in anim exercitation aliquip irure adipisicing ad proident sunt fugiat. Reprehenderit laboris ullamco tempor nulla aliquip occaecat ad culpa duis nisi. Eiusmod deserunt laborum velit laborum elit in quis et amet irure fugiat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
