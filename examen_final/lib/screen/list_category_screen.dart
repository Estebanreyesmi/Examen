import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:examen_final/models/categoria.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryService categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: Center(
        child: FutureBuilder(
          future: categoryService.loadCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: categoryService.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryService.categories[index];
                  return ListTile(
                    title: Text(category.categoryName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Lógica para editar la categoría
                            // Aquí puedes abrir un diálogo o navegar a otra pantalla para editar la categoría
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Lógica para eliminar la categoría
                            categoryService.deleteCategory(category, context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
