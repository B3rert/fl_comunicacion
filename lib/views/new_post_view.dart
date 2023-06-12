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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _vm.createPost(context),
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(),
      body: _vm.isLoading
          ? const LoadWidget()
          : SingleChildScrollView(
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
    );
  }
}
