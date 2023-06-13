import 'package:fl_comunicacion/view_models/new_post_view_model.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<NewPostViewModel>(context);

    return Scaffold(
      floatingActionButton: _vm.isLoading
          ? null
          : FloatingActionButton(
              onPressed: () => _vm.createPost(context),
              child: const Icon(Icons.save),
            ),
      appBar: AppBar(),
      body: _vm.isLoading
          ? const LoadWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Nueva publicación",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CardWidget(
                      width: double.infinity,
                      height: 330,
                      raidus: 22,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _vm.formKey,
                          child: Column(
                            children: [
                              InputWidget(
                                hintText: "Titulo",
                                labelText: "Titutlo",
                                maxLines: 1,
                                formProperty: "title",
                                formValues: _vm.formValues,
                              ),
                              InputWidget(
                                validator: false,
                                hintText: "Descripcion",
                                labelText: "Descripcion",
                                maxLines: 4,
                                formProperty: "description",
                                formValues: _vm.formValues,
                              ),
                            ],
                          ),
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
