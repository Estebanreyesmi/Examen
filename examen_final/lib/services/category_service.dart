import 'dart:convert';
import 'package:examen_final/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriaService with ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<CategoriaItem> categorias = [];
  CategoriaItem? selectedCategoria;
  bool isLoading = true;
  bool isEditCreate = true;

  CategoriaService() {
    loadCategorias();
  }

  Future loadCategorias() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final categoriasMap = Categoria.fromJson(response.body);
    print(response.body);
    categorias = categoriasMap.categoriaList;
    isLoading = false;
    notifyListeners();
  }

  Future<void> editOrCreateCategoria(CategoriaItem categoria) async {
    isEditCreate = true;
    notifyListeners();
    if (categoria.categoryId == 0) {
      await createCategoria(categoria);
    } else {
      await updateCategoria(categoria);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future<String> updateCategoria(CategoriaItem categoria) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: categoria.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    // Actualizar la lista de categorías
    final index = categorias
        .indexWhere((element) => element.categoryId == categoria.categoryId);
    categorias[index] = categoria;

    return '';
  }

  Future<void> createCategoria(CategoriaItem categoria) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: categoria.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.categorias.add(categoria);
  }

  Future<void> deleteCategoria(
      CategoriaItem categoria, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: categoria.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.categorias.clear();
    loadCategorias();
    Navigator.of(context).pushNamed('cat');
  }
}
