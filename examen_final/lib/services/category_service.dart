import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    final categoriesMap = Categoria.fromJson(response.body);
    print(response.body);
    categories = categoriesMap.listado;
    isLoading = false;
    notifyListeners();
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
  }
}

class Categoria {
  Categoria({
    required this.listado,
  });

  List<Listado> listado;

  factory Categoria.fromJson(String str) => Categoria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categoria.fromMap(Map<String, dynamic> json) => Categoria(
        listado:
            List<Listado>.from(json["Listado"].map((x) => Listado.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Listado {
  Listado({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };

  Listado copy() => Listado(
        categoryId: categoryId,
        categoryName: categoryName,
        categoryState: categoryState,
      );
}
