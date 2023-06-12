import 'package:fl_comunicacion/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              InputWidget(
                  maxLines: maxLines,
                  formProperty: formProperty,
                  formValues: formValues)
            ],
          ),
        ),
      ),
    );
  }
}
