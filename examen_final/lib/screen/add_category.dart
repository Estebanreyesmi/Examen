import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarCategoriaScreen extends StatefulWidget {
  @override
  _AgregarCategoriaScreenState createState() => _AgregarCategoriaScreenState();
}

class _AgregarCategoriaScreenState extends State<AgregarCategoriaScreen> {
  final TextEditingController _nombreController = TextEditingController();

  bool _estado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre de la categoría'),
            ),
            SwitchListTile(
              title: Text('Estado de la categoría'),
              value: _estado,
              onChanged: (value) {
                setState(() {
                  _estado = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _agregarCategoria(context),
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarCategoria(BuildContext context) {
    final String nombre = _nombreController.text.trim();

    if (nombre.isNotEmpty) {
      final CategoriaItem nuevaCategoria = CategoriaItem(
        categoryId: 0,
        categoryName: nombre,
        categoryState: _estado ? 'Activo' : 'Inactivo',
      );

      Provider.of<CategoriaService>(context, listen: false)
          .createCategoria(nuevaCategoria);

      Navigator.of(context)
          .pop(); // Regresa a la pantalla anterior después de agregar la categoría
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, completa todos los campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }
}
