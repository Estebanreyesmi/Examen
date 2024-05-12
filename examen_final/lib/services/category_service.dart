import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen_final/models/categoria.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050'; // Cambia a tu URL base
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Category> categories = [];
  Category? selectedCategory;
  bool isLoading = true;

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
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> categoriesJson = jsonResponse['categories'];
    categories = categoriesJson.map((json) => Category.fromMap(json)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateCategory(Category category) async {
    notifyListeners();
    if (category.categoryId == 0) {
      await createCategory(category);
    } else {
      await updateCategory(category);
    }
    notifyListeners();
  }

  Future<String> updateCategory(Category category) async {
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

    // Actualizar la lista de categorías
    final index = categories
        .indexWhere((element) => element.categoryId == category.categoryId);
    categories[index] = category;

    return '';
  }

  Future createCategory(Category category) async {
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
    this.categories.add(category);
    return '';
  }

  Future deleteCategory(Category category, BuildContext context) async {
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
    this.categories.clear(); // Borra toda la lista de categorías
    loadCategories();
    Navigator.of(context).pushNamed('list');
    return '';
  }
}
