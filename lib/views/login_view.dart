import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _vm.navigateConfigApi(context),
            icon: const Icon(
              Icons.vpn_lock_outlined,
            ),
          )
        ],
      ),
      body: _vm.isLoading
          ? const LoadWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    const Center(
                      child: Image(
                        height: 125,
                        image: AssetImage("assets/empresa.png"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CardWidget(
                      width: double.infinity,
                      height: 375,
                      raidus: 18,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: _vm.formKey,
                              child: Column(
                                children: [
                                  InputWidget(
                                    formProperty: 'user',
                                    formValues: _vm.formValues,
                                    maxLines: 1,
                                    initialValue: '',
                                    hintText: 'Usuario',
                                    labelText: 'Usuario',
                                    suffixIcon: Icons.person,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Contraseña',
                                              labelText: 'Contraseña',
                                              suffixIcon: IconButton(
                                                onPressed: _vm.toggle,
                                                icon: Icon(
                                                  _vm.obscureText
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: AppTheme.primary,
                                                ),
                                              )),
                                          onChanged: (value) => {
                                            _vm.formValues['pass'] = value,
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Campo requerido.';
                                            }
                                            return null;
                                          },
                                          obscureText: _vm.obscureText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SwitchListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              activeColor: AppTheme.primary,
                              title: const Text(
                                'Mantener sesión iniciada',
                                style: TextStyle(
                                  color: AppTheme.primary,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              value: _vm.isSliderDisabledSession,
                              onChanged: (value) => _vm.disableSession(value),
                            ),
                            ElevatedButton(
                              onPressed: () => _vm.login(context),
                              child: const SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text("Iniciar sesión"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Image(
                        height: 120,
                        image: AssetImage("assets/logo_demosoft.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
