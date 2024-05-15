import 'package:examen_final/models/categoria.dart';
import 'package:examen_final/screen/loading_screen.dart';
import 'package:examen_final/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCategoriaScreen extends StatelessWidget {
  const ListCategoriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriaService = Provider.of<CategoriaService>(context);
    if (categoriaService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de categorías'),
      ),
      body: ListView.builder(
        itemCount: categoriaService.categorias.length,
        itemBuilder: (BuildContext context, index) {
          final categoria = categoriaService.categorias[index];
          return ListTile(
            title: Text(categoria.categoryName),
            subtitle: Text(categoria.categoryState),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoriaService.selectedCategoria =
              CategoriaItem(categoryId: 0, categoryName: '', categoryState: '');
          Navigator.pushNamed(context, 'edit');
        },
      ),
    );
  }
}
