import 'dart:convert';
import 'package:examen_final/models/proveedores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProveedorService with ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8050';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ProveedorItem> proveedores = [];
  ProveedorItem? selectedProveedor;
  bool isLoading = true;
  bool isEditCreate = true;

  ProveedorService() {
    loadProveedores();
  }

  Future loadProveedores() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/provider_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final proveedoresMap = Proveedor.fromJson(response.body);
    print(response.body);
    proveedores = proveedoresMap.proveedorList;
    isLoading = false;
    notifyListeners();
  }

  Future<void> editOrCreateProveedor(ProveedorItem proveedor) async {
    isEditCreate = true;
    notifyListeners();
    if (proveedor.providerName.isEmpty) {
      await createProveedor(proveedor);
    } else {
      await updateProveedor(proveedor);
    }
    isEditCreate = false;
    notifyListeners();
    loadProveedores();
  }

  Future<String> updateProveedor(ProveedorItem proveedor) async {
    final url = Uri.http(_baseUrl, 'ejemplos/proveedor_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    // Actualizar la lista de proveedores
    final index = proveedores
        .indexWhere((element) => element.providerId == proveedor.providerId);
    proveedores[index] = proveedor;
    loadProveedores();

    return '';
  }

  Future<void> createProveedor(ProveedorItem proveedor) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedores.add(proveedor);
    loadProveedores();
  }

  Future<void> deleteProveedor(
      ProveedorItem proveedor, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/provider_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedores.clear();
    loadProveedores();
  }
}
