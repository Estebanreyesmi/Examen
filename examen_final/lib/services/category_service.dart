import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:examen_final/models/categoria.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> categories = [];
  Listado? selectedCategory;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    final categoriesMap = Category.fromJson(response.body);
    print(response.body);
    categories = categoriesMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(Listado category) async {
    isEditCreate = true;
    notifyListeners();

    if (category.categoryId == 0) {
      await createCategory(category);
    } else {
      await updateCategory(category);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateCategory(Listado category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    final index = categories
        .indexWhere((element) => element.categoryId == category.categoryId);
    categories[index] = category;

    return '';
  }

  Future createCategory(Listado category) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    categories.add(category);
    return '';
  }

  Future deleteCategory(Listado category, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/category_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    final response = await http.post(url, body: category.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });

    final decodeResp = response.body;
    print(decodeResp);

    categories.clear(); // Borra todo el listado
    loadCategories();

    Navigator.of(context).pushNamed('list');
    return '';
  }
}
