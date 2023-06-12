import 'package:flutter/material.dart';

class NewPostViewModel extends ChangeNotifier {
  bool isLoading = false;

  //Map form
  final Map<String, String> formValues = {
    'title': '',
    'description': '',
  };

  //Key for form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //True if form is valid
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  createPost() {
    if (!isValidForm()) return;
    print(formValues);
  }
}
