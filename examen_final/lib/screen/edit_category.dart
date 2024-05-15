import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCategoriaScreen extends StatefulWidget {
  const EditCategoriaScreen({Key? key}) : super(key: key);

  @override
  _EditCategoriaScreenState createState() => _EditCategoriaScreenState();
}

class _EditCategoriaScreenState extends State<EditCategoriaScreen> {
  late TextEditingController _nombreController;
  late bool _estado;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador de texto y el estado con los valores de la categoría seleccionada mmm revisar
    final categoriaService =
        Provider.of<CategoriaService>(context, listen: false);
    final selectedCategoria = categoriaService.selectedCategoria;
    _nombreController =
        TextEditingController(text: selectedCategoria?.categoryName ?? '');
    _estado = selectedCategoria?.categoryState == 'Activo';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration:
                  const InputDecoration(labelText: 'Nombre de la categoría'),
            ),
            SwitchListTile(
              title: const Text('Estado de la categoría'),
              value: _estado ?? false,
              onChanged: (value) {
                setState(() {
                  _estado = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _guardarCambios(context),
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  void _guardarCambios(BuildContext context) {
    // Actualiza los valores de la categoría seleccionada con los nuevos valores del formulario
    final categoriaService =
        Provider.of<CategoriaService>(context, listen: false);
    final String nombre = _nombreController.text.trim();
    final String estado = _estado ? 'Activo' : 'Inactivo';

    if (nombre.isNotEmpty) {
      final CategoriaItem categoriaActualizada = CategoriaItem(
        categoryId: categoriaService.selectedCategoria?.categoryId ?? 0,
        categoryName: nombre,
        categoryState: estado,
      );

      categoriaService.updateCategoria(categoriaActualizada);

      Navigator.of(context)
          .pop(); // Regresa a la pantalla anterior después de guardar los cambios
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Por favor, completa todos los campos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose del controlador de texto cuando el widget se descarte
    _nombreController.dispose();
    super.dispose();
  }
}
