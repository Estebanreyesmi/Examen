import 'package:flutter/material.dart';
import 'package:examen_final/models/categoria.dart'; // Asegúrate de importar el modelo de categorías
import 'package:examen_final/services/category_service.dart'; // Asegúrate de importar el servicio de categorías
import 'package:examen_final/widgets/categorias.dart'; // Asegúrate de importar la tarjeta de categorías
import 'package:provider/provider.dart';
import 'package:examen_final/screen/screen.dart'; // Importa cualquier otra pantalla necesaria

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    // Muestra una pantalla de carga si el servicio está cargando las categorías
    if (categoryService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de categorías'),
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            // Cuando se toca una categoría, puedes hacer lo que necesites aquí
          },
          child: CategoryCard(category: categoryService.categories[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navega a una pantalla para agregar una nueva categoría
          Navigator.pushNamed(context, 'add_category');
        },
      ),
    );
  }
}
