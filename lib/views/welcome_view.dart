import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/welcome_view_model.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    final _homeVM = Provider.of<WelcomeViewModel>(context, listen: false);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _homeVM.loadData(context));
  }

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<WelcomeViewModel>(context);

    return Scaffold(
      bottomNavigationBar: _vm.isLoading
          ? null
          : GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'feed'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                child: CardWidget(
                  width: double.infinity,
                  height: 70,
                  raidus: 20,
                  child: Container(
                    color: AppTheme.primary,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
        actions: _vm.isLoading
            ? null
            : [
                IconButton(
                  onPressed: () => _vm.logout(context),
                  icon: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
      ),
      body: _vm.isLoading
          ? const LoadWidget()
          : RefreshIndicator(
              onRefresh: () => _vm.loadData(context),
              child: _vm.mensajes.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 75),
                        NotFoundWidget(),
                      ],
                    )
                  : ListView(
                      children: [
                        const SizedBox(height: 75),
                        // Center(
                        //   child: FadeInImage(
                        //     height: 450,
                        //     image: const NetworkImage(
                        //         "https://static.vecteezy.com/system/resources/previews/001/270/267/original/boy-studying-online-in-relax-mode-vector.jpg"),
                        //     placeholder: const AssetImage("placeimg.jpg"),
                        //     imageErrorBuilder: (context, error, stackTrace) {
                        //       return Image.asset(
                        //         'assets/banner.png',
                        //         fit: BoxFit.cover,
                        //       );
                        //     },
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        Center(
                          child: Text(
                            _vm.mensajes[0].descripcion,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            clipBehavior: Clip.antiAlias,
                            color: AppTheme.backroundColorSecondary,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                _vm.mensajes[0].observacion1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            _formatDate(_vm.mensajes[0].fechaHora),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}

//Funcion formatear fecha con intl
String _formatDate(String date) {
  var parsedDate = DateTime.parse(date);

  String datetime1 = DateFormat("dd/MM/yyyy hh:mm").format(parsedDate);

  return datetime1;
}
