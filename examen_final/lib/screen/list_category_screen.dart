import 'package:flutter/material.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:provider/provider.dart';

class ListaCategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
      ),
      body: Consumer<CategoryService>(
        builder: (context, categoryService, _) {
          if (categoryService.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: categoryService.categories.length,
              itemBuilder: (context, index) {
                final category = categoryService.categories[index];
                return ListTile(
                  title: Text(category.categoryName),
                  subtitle: Text('Estado: ${category.categoryState}'),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
