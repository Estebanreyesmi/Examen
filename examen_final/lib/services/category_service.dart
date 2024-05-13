import 'dart:convert';
import 'package:examen_final/models/categoria.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String _baseUrl = "143.198.118.203:8050";
  final String _user = "test";
  final String _pass = "test2023";

  Future<List<Category>> getCategoryList() async {
    final response = await http.get(
        Uri.http(_baseUrl, 'ejemplos/category_list_rest/'),
        headers: _createHeaders());
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(Category category) async {
    final response = await http.post(
      Uri.http(_baseUrl, 'ejemplos/category_add_rest/'),
      headers: _createHeaders(),
      body: json.encode(category.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add category');
    }
  }

  Future<void> editCategory(Category category) async {
    final response = await http.post(
      Uri.http(_baseUrl, 'ejemplos/category_edit_rest/'),
      headers: _createHeaders(),
      body: json.encode(category.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit category');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    final response = await http.post(
      Uri.http(_baseUrl, 'ejemplos/category_del_rest/'),
      headers: _createHeaders(),
      body: json.encode({'category_id': categoryId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }

  Map<String, String> _createHeaders() {
    return {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$_user:$_pass')),
      'Content-Type': 'application/json',
    };
  }
}
