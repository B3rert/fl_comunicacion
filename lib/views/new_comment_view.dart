import 'package:fl_comunicacion/models/models.dart';
import 'package:fl_comunicacion/view_models/view_models.dart';
import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewCommentView extends StatelessWidget {
  const NewCommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vm = Provider.of<NewCommentViewModel>(context);

    final PostModel post =
        ModalRoute.of(context)!.settings.arguments as PostModel;

    return Scaffold(
      floatingActionButton: _vm.isLoading
          ? null
          : FloatingActionButton(
              onPressed: () => _vm.createComment(context, post),
              child: const Icon(Icons.save),
            ),
      appBar: AppBar(),
      body: _vm.isLoading
          ? const LoadWidget()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: CardWidget(
                  width: double.infinity,
                  height: 220,
                  raidus: 22,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _vm.formKey,
                      child: Column(
                        children: [
                          InputWidget(
                            hintText: "Comentario",
                            labelText: "Comentario",
                            maxLines: 4,
                            formProperty: "title",
                            formValues: _vm.formValues,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
