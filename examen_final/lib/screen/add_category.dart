import 'package:flutter/material.dart';
import 'package:examen_final/services/category_service.dart'; // Asegúrate de importar el servicio de categorías

class AgregarCategoriaScreen extends StatefulWidget {
  @override
  _AgregarCategoriaScreenState createState() => _AgregarCategoriaScreenState();
}

class _AgregarCategoriaScreenState extends State<AgregarCategoriaScreen> {
  final TextEditingController _nombreController = TextEditingController();
  bool _isActive = true; // Estado por defecto activo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre de la categoría',
              ),
            ),
            SwitchListTile(
              title: Text('Activo'),
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Crear la categoría utilizando el servicio
                final newCategory = Listado(
                  categoryId:
                      0, // El ID se establecerá automáticamente en el servidor
                  categoryName: _nombreController.text,
                  categoryState: _isActive ? 'activo' : 'inactivo',
                );
                await CategoryService().createCategory(newCategory);

                // Navegar de regreso a la pantalla anterior
                Navigator.pop(context);
              },
              child: Text('Agregar Categoría'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }
}
