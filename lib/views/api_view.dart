import 'package:fl_comunicacion/shared_preferences/preferences.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiView extends StatelessWidget {
  const ApiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<ApiViewModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: _vm.isLoading
          ? const LoadWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Preferences.baseUrl.isEmpty)
                            const Text(
                              "Url Apis",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (Preferences.baseUrl.isEmpty)
                            const SizedBox(height: 10),
                          if (Preferences.baseUrl.isEmpty)
                            const Text(
                              "Para poder utilizar nuestros servicios, por favor, introduce una URL válida. ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          if (Preferences.baseUrl.isNotEmpty)
                            const SizedBox(height: 20),
                          if (Preferences.baseUrl.isNotEmpty)
                            const Text(
                              "Url Actual",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (Preferences.baseUrl.isNotEmpty)
                            const SizedBox(height: 10),
                          if (Preferences.baseUrl.isNotEmpty)
                            Text(
                              "${Preferences.prefix}//${Preferences.baseUrl}/${Preferences.path}${Preferences.path.isEmpty ? '' : Preferences.path + '/'}api/",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CardWidget(
                      width: double.infinity,
                      height: 200,
                      raidus: 18,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _vm.formKey,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText:
                                      'https://ds.demosoftonline.com/api/',
                                  labelText: 'Url',
                                ),
                                onChanged: (value) => {
                                  _vm.url = value,
                                },
                                validator: (value) {
                                  String pattern =
                                      r"^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$";
                                  RegExp regExp = RegExp(pattern);

                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'Url invalida';
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (Preferences.baseUrl.isNotEmpty)
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      // onPressed: () => Preferences.clearUrl(),

                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text("Cancelar"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _vm.connectService(context),
                                      child: const SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: Text("Cambiar"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (Preferences.baseUrl.isEmpty)
                              ElevatedButton(
                                onPressed: () => _vm.connectService(context),
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("Aceptar"),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
