import 'package:flutter/material.dart';
import 'package:examen_final/models/categoria.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CategoriaItem categoriaList;

  CategoryFormProvider(this.categoriaList);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
