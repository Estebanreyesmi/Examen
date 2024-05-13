import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryFormScreen extends StatefulWidget {
  @override
  _CategoryFormScreenState createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Obtener los valores del formulario
    final String name = _nameController.text;
    final String state = _stateController.text;

    if (name.isEmpty || state.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, completa todos los campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Crear la instancia de la categoría con los datos del formulario
    final Category newCategory = Category(
      id: 0, // Esto puede ser cualquier valor ya que el servidor generará el ID
      name: name,
      state: state,
    );

    CategoryService categoryService = CategoryService(
      baseUrl: _baseUrl,
      user: _user,
      pass: _pass,
    );
    categoryService.addCategory(newCategory).then((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Éxito'),
            content: Text('La categoría se ha agregado correctamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Manejar errores
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Hubo un error al agregar la categoría. Por favor, inténtalo de nuevo más tarde.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
